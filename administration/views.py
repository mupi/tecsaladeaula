# -*- coding: utf-8 -*-
from __future__ import division
from django.views.generic import TemplateView, DetailView
from django.views.generic.base import TemplateResponseMixin, ContextMixin, View
from django.views.generic.edit import ModelFormMixin
from django.http import HttpResponse, HttpResponseRedirect
from django.db.models import Q
from django.core.exceptions import PermissionDenied
from django.core.urlresolvers import reverse_lazy
from django.core.files import File as DjangoFile
from django.contrib.auth import get_user_model
from django.utils.text import slugify
from django.conf import settings
from django.utils.six import BytesIO
from braces import views
from rest_framework.renderers import JSONRenderer
from rest_framework.parsers import JSONParser
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import permissions
from core.models import Course, CourseProfessor
from course_material.models import File as TimtecFile
from .serializer import CourseExportSerializer, CourseImportSerializer

from accounts.models import TimtecUser, Discipline
from django.utils import timezone
from datetime import timedelta, time, datetime
from core.models import CourseStudent, StudentProgress
from joca.models import JocaUser

import tarfile
import StringIO
import os
import csv

User = get_user_model()


class AdminMixin(TemplateResponseMixin, ContextMixin,):
    def get_context_data(self, **kwargs):
        context = super(AdminMixin, self).get_context_data(**kwargs)
        context['in_admin'] = True
        return context

    def get_template_names(self):
        """
        Returns two template options, either the administration specific
        or the common template
        """
        return ['administration/' + self.template_name, self.template_name]


class AdminView(AdminMixin, TemplateView, views.AccessMixin):
    raise_exception = True

    def dispatch(self, request, *args, **kwargs):

        response = super(AdminView, self).dispatch(
            request, *args, **kwargs)

        if not (request.user.is_superuser or CourseProfessor.objects.filter(user=request.user, role='coordinator').exists()):
            if self.raise_exception:  # *and* if an exception was desired
                raise PermissionDenied  # return a forbidden response.

        return response


class UserAdminView(AdminView):
    def get_context_data(self, **kwargs):
        context = super(UserAdminView, self).get_context_data(**kwargs)
        context['total_users_number'] = User.objects.count()
        return context

class ExportUsersView(View):
    def generate_string_from_array(self, array):
        first = True
        string_from_array = ''
        for o in array.all():
            if first:
                first = False
                string_from_array = ''.join((string_from_array, o.name.encode('utf-8')))
            else:
                string_from_array = '\n'.join((string_from_array, o.name.encode('utf-8')))
        return string_from_array

    def generate_string_for_school(self, user_schools):
        first = True

        string_for_school = ''
        for userschool in user_schools.all():
            s = userschool.school

            if first:
                first = False
                string_for_school = s.name.encode('utf-8')
            else:
                string_for_school = '\n'.join((string_for_school, s.name.encode('utf-8')))
        return string_for_school

    def generate_string_for_school_type(self, user_schools):
        first = True

        string_for_school_type = ''
        for userschool in user_schools.all():
            s = userschool.school

            if first:
                first = False
                string_for_school_type = s.get_school_type_display().encode('utf-8')
            else:
                string_for_school_type = '\n'.join((string_for_school_type, s.get_school_type_display().encode('utf-8')))
        return string_for_school_type

    def generate_string_for_course(self, courses):
        first = True
        string_for_course = ''
        for c in courses.all():
            if first:
                first = False
                string_for_course = ''.join((string_for_course, c.course.name.encode('utf-8'), ' | ', str(c.percent_progress()), '%'))
            else:
                string_for_course = '\n'.join((string_for_course, c.course.name.encode('utf-8') + ' | ' + str(c.percent_progress()) + '%'))
        return string_for_course


    def get(self, request, *args, **kwargs):
        response = HttpResponse(content_type='text/csv')
        response['Content-Disposition'] = 'attachment; filename="alunos.csv"'

        writer = csv.writer(response)
        writer.writerow([
            'Nome',
            'Email',
            'Email Adicional',
            'Ocupação',
            'Disciplinas',
            'Niveis de ensino',
            'Estado',
            'Cidade',
            'Sobre mim',
            'CPF',
            'RG',
            'Telefone',
            'Escola',
            'Tipo de Escola',
            'Cursos',
            'Administrador',
            'Ativo',
        ])

        keyword = request.GET.get('keyword')
        admin = request.GET.get('admin')
        blocked = request.GET.get('blocked')
        uf = request.GET.get('uf')
        city = request.GET.get('city')
        occupations = request.GET.getlist('occupations')
        disciplines = request.GET.getlist('disciplines')
        queryset = User.objects.all()

        if admin == 'true':
            queryset = queryset.filter(is_superuser=True)

        if blocked == 'true':
            queryset = queryset.filter(is_active=False)

        if keyword:
            queryset = queryset.filter(Q(first_name__icontains=keyword) |
                                       Q(last_name__icontains=keyword) |
                                       Q(username__icontains=keyword) |
                                       Q(email__icontains=keyword))
        if occupations:
            queryset = queryset.filter(occupations__in=occupations).distinct()

        if disciplines:
            if '-1' in disciplines:
                other_disciplines = Discipline.objects.filter(visible=False)
                for d in other_disciplines:
                    disciplines.append(d.id)
            queryset = queryset.filter(disciplines__in=disciplines).distinct()

        if uf:
            queryset = queryset.filter(city__uf=uf)
        if city:
            queryset = queryset.filter(city__id=city)

        for u in queryset:
            adm = 'N'
            ativo = 'N'
            if(u.is_staff):
                adm = 'S'
            if(u.is_active):
                ativo = 'S'
            occupations = self.generate_string_from_array(u.occupations)
            disciplines = self.generate_string_from_array(u.disciplines)
            education_levels = self.generate_string_from_array(u.education_levels)
            schools = self.generate_string_for_school(u.timtecuserschool_set)
            schools_types = self.generate_string_for_school_type(u.timtecuserschool_set)
            courses = self.generate_string_for_course(u.coursestudent_set)
            writer.writerow([
                u.get_full_name().encode('utf-8'),
                u.email,
                u.business_email if u.business_email is not None else "",
                occupations,
                disciplines,
                education_levels,
                (u.city.uf.name.encode('utf-8') if u.city is not None else ""),
                (u.city.name.encode('utf-8') if u.city is not None else ""),
                u.biography.encode('utf-8'),
                u.cpf,
                u.rg,
                u.phone,
                schools,
                schools_types,
                courses,
                adm,
                ativo,
            ])

        return response
from django.db import connection
class ExportUsersByCourseView(ExportUsersView):

    def generate_string_for_date(self, date):
        if date == None:
            return ''
        return '{}/{}/{}'.format(date.day, date.month, date.year)

    def generate_string_for_progress(self, course_student, unit_count, all_units_counts_user):
        if unit_count <= 0:
            return '0%'
        user = course_student.user

        units_done_len = all_units_counts_user.get(user.id, {}).get('all', 0)
        percent = int(units_done_len / unit_count * 100)
        
        return '{}%'.format(percent)
    
    def generate_string_for_lessons(self, course_student, published_lessons, lessons_qty, all_units_counts_user):
        user = course_student.user
        course = course_student.course
        all_units_dones = all_units_counts_user.get(user.id, {})

        string_for_lesson = ''
        for lesson in published_lessons:
            units_done_len = all_units_dones.get(lesson.id, 0)
            percentage = int(units_done_len / lessons_qty[lesson.id] * 100)

            if not string_for_lesson:
                string_for_lesson += '{} | {}%'.format(lesson.name.encode('utf-8'), percentage)
            else:
                string_for_lesson += '\n{} | {}%'.format(lesson.name.encode('utf-8'), percentage)

        return string_for_lesson

    def get(self, request, *args, **kwargs):
        course_id = request.GET.get('course_id')
        course = Course.objects.get(id=course_id)

        queryset = CourseStudent.objects.filter(course=course_id).prefetch_related('course__lessons',
            'user__occupations', 'user__disciplines', 'user__education_levels', 'user__timtecuserschool_set',
            'user__timtecuserschool_set__school', 'user__city', 'user__city__uf')
        course_id = request.GET.get('course_id')
        keyword = request.GET.get('keyword')
        from_date = request.GET.get('from_date')
        until_date = request.GET.get('until_date')
        percentage_completion = request.GET.get('percentage_completion')
        days_inactive = request.GET.get('days_inactive')

        queryset = queryset.filter(course=course_id)

        if keyword:
            queryset = queryset.filter(Q(user__first_name__icontains=keyword) |
                                       Q(user__last_name__icontains=keyword) |
                                       Q(user__username__icontains=keyword) |
                                       Q(user__email__icontains=keyword))

        if from_date:
            from_date = datetime.fromtimestamp(int(from_date) / 1000)

            t = time(0, 0, 0, tzinfo=timezone.get_current_timezone())
            from_date = datetime.combine(from_date.date(), t)
            queryset = queryset.filter(created_at__gte=from_date)
        if until_date:
            until_date = datetime.fromtimestamp(int(until_date) / 1000)

            t = time(23, 59, 59, tzinfo=timezone.get_current_timezone())
            until_date = datetime.combine(until_date.date(), t)
            queryset = queryset.filter(created_at__lte=until_date)

        course_students = [cs for cs in queryset]
        if percentage_completion:
            if percentage_completion == '1':
                course_students = [cs for cs in course_students if cs.percent_progress() == 0]
            elif percentage_completion == '2':
                course_students = [cs for cs in course_students if cs.percent_progress() > 0 and cs.percent_progress() < 50]
            elif percentage_completion == '3':
                course_students = [cs for cs in course_students if cs.percent_progress() >= 50 and cs.percent_progress() < 80]
            elif percentage_completion == '4':
                course_students = [cs for cs in course_students if cs.percent_progress() >= 80]

        if days_inactive:
            days_inactive = int(days_inactive)
            from_date = datetime.now() - timedelta(days=days_inactive)
            t = time(0, 0, 0, tzinfo=timezone.get_current_timezone())
            from_date = datetime.combine(from_date.date(), t)
            course_students = [cs for cs in course_students if cs.get_last_access() == None or cs.get_last_access() <= from_date]

        # precomputed useful variables

        unit_count = course.unit_set.count()

        published_lessons = course.lessons.filter(status='published')

        lessons_qty = {}
        for lesson in published_lessons:
            lessons_qty[lesson.id] = lesson.unit_count()

        all_units_dones = StudentProgress.objects.exclude(complete=None)\
                                .filter(unit__lesson__course=course)\
                                .select_related('unit__lesson', 'user')

        all_units_counts_user = {}
        for unit_done in all_units_dones:
            user_id = unit_done.user.id
            lesson_id = unit_done.unit.lesson.id

            if user_id in all_units_counts_user:
                all_units_counts_user[user_id]['all'] += 1
                if lesson_id in all_units_counts_user[user_id]:
                    all_units_counts_user[user_id][lesson_id] += 1
                else:
                    all_units_counts_user[user_id][lesson_id] = 1
            else:
                all_units_counts_user[user_id] = {lesson_id : 1, 'all' : 1}

        all_last_accesses = {}
        for sp in StudentProgress.objects.exclude(complete=None)\
                .filter(unit__lesson=lesson) \
                .order_by('user__id', '-last_access').distinct('user__id'):
            all_last_accesses[sp.user.id] = sp.last_access
                
        response = HttpResponse(content_type='text/csv')
        response['Content-Disposition'] = 'attachment; filename="alunos_-_'+course.name+'.csv"'
        
        writer = csv.writer(response)
        writer.writerow([
            'Nome',
            'Situação',
            'Email',
            'Email Adicional',
            'Ocupação',
            'Disciplinas',
            'Niveis de ensino',
            'Estado',
            'Cidade',
            'Sobre mim',
            'CPF',
            'RG',
            'Telefone',
            'Escola',
            'Tipo de Escola',
            'Progresso',
            'Data Inscrição',
            'Último Acesso',
            'Aulas'
        ])
        for course_student in course_students:
            u = course_student.user

            if(course_student):
                if course_student.status == '1':
                    status = 'Pendente'
                elif course_student.status == '2':
                    status = 'Ativo'
                else:
                    status = 'Cancelado'

                occupations = self.generate_string_from_array(u.occupations)
                disciplines = self.generate_string_from_array(u.disciplines)
                education_levels = self.generate_string_from_array(u.education_levels)
                schools = self.generate_string_for_school(u.timtecuserschool_set)
                schools_types = self.generate_string_for_school_type(u.timtecuserschool_set)
                progress = self.generate_string_for_progress(course_student, unit_count, all_units_counts_user)
                subscribe_date = self.generate_string_for_date(course_student.created_at)
                last_access = self.generate_string_for_date(all_last_accesses.get(u.id))
                lessons = self.generate_string_for_lessons(course_student, published_lessons, lessons_qty, all_units_counts_user)

                writer.writerow([
                    u.get_full_name().encode('utf-8'),
                    status,
                    u.email,
                    u.business_email if u.business_email is not None else "",
                    occupations,
                    disciplines,
                    education_levels,
                    (u.city.uf.name.encode('utf-8') if u.city is not None else ""),
                    (u.city.name.encode('utf-8') if u.city is not None else ""),
                    u.biography.encode('utf-8'),
                    u.cpf,
                    u.rg,
                    u.phone,
                    schools,
                    schools_types,
                    progress,
                    subscribe_date,
                    last_access,
                    lessons,
                ])
        return response

class CourseAdminView(AdminMixin, DetailView, views.AccessMixin):
    model = Course
    context_object_name = 'course'
    pk_url_kwarg = 'course_id'
    raise_exception = True

    def dispatch(self, request, *args, **kwargs):

        response = super(CourseAdminView, self).dispatch(
            request, *args, **kwargs)

        if not (request.user.is_superuser or self.object.get_professor_role(request.user) == 'coordinator'):
            if self.raise_exception:  # *and* if an exception was desired
                raise PermissionDenied  # return a forbidden response.

        return response


class CourseCreateView(views.SuperuserRequiredMixin, View, ModelFormMixin):
    model = Course
    fields = ('name',)
    raise_exception = True

    def post(self, request, *args, **kwargs):
        """
        Handles POST requests, instantiating a form instance with the passed
        POST variables and then checked for validity.
        """
        self.object = None
        form_class = self.get_form_class()
        form = self.get_form(form_class)
        if form.is_valid():
            return self.form_valid(form)
        else:
            return self.form_invalid(form)

    def form_valid(self, form):
        base_slug = slugify(form.instance.name)
        slug = base_slug
        i = 1
        while Course.objects.filter(slug=slug).exists():
            slug = base_slug + str(i)
            i += 1
        form.instance.slug = slug
        return super(CourseCreateView, self).form_valid(form)

    def form_invalid(self, form):
        return HttpResponseRedirect(reverse_lazy('administration.courses'))

    def get_success_url(self):
        return reverse_lazy('administration.edit_course', kwargs={'course_id': self.object.id})


class ExportCourseView(views.SuperuserRequiredMixin, View):

    @staticmethod
    def add_files_to_export(tar_file, short_file_path):
        full_file_path = settings.MEDIA_ROOT + '/' + short_file_path
        if os.path.isfile(full_file_path):
                tar_file.add(full_file_path,
                             arcname=short_file_path)

    def get(self, request, *args, **kwargs):

        course_id = kwargs.get('course_id')
        course = Course.objects.get(id=course_id)

        course_serializer = CourseExportSerializer(course)

        json_file = StringIO.StringIO(JSONRenderer().render(course_serializer.data))

        tar_info = tarfile.TarInfo('course.json')
        tar_info.size = json_file.len

        response = HttpResponse(content_type='application/x-compressed-tar')
        response['Content-Disposition'] = 'attachment; filename={}'.format(course.slug + '.tar.gz')

        course_tar_file = tarfile.open(fileobj=response, mode='w:gz')
        course_tar_file.addfile(tar_info, json_file)

        course_authors = course_serializer.data.get('course_authors')
        for course_author in course_authors:
            picture_path = course_author.get('picture')
            if picture_path:
                picture_path = picture_path.split('/', 2)[-1]
                self.add_files_to_export(course_tar_file, picture_path)

        course_thumbnail_path = course_serializer.data.get('thumbnail')
        if course_thumbnail_path:
            self.add_files_to_export(course_tar_file, course_thumbnail_path)

        course_home_thumbnail_path = course_serializer.data.get('home_thumbnail')
        if course_home_thumbnail_path:
            self.add_files_to_export(course_tar_file, course_home_thumbnail_path)

        course_material = course_serializer.data.get('course_material')
        if course_material:
            for course_material_file in course_material['files']:
                course_material_file_path = course_material_file['file']
                self.add_files_to_export(course_tar_file, course_material_file_path)

        course_tar_file.close()

        return response


class ImportCourseView(APIView):

    renderer_classes = (JSONRenderer,)
    permission_classes = (permissions.IsAdminUser,)

    def post(self, request, *args, **kwargs):
        import_file = tarfile.open(fileobj=request.FILES.get('course-import-file'), mode='r:gz')
        file_names = import_file.getnames()

        json_file_name = [s for s in file_names if '.json' in s][0]

        json_file = import_file.extractfile(json_file_name)

        stream = BytesIO(json_file.read())
        course_data = JSONParser().parse(stream)
        course_slug = course_data.get('slug')
        try:
            course = Course.objects.get(slug=course_slug)
            if course.has_started:
                return Response({'error': 'course_started'})
            elif not request.DATA.get('force'):
                return Response({'error': 'course_exists'})

        except Course.DoesNotExist:
            course = None

        course_thumbnail_path = course_data.pop('thumbnail')
        course_home_thumbnail_path = course_data.pop('home_thumbnail')

        # Save course professor images
        course_author_pictures = {}
        for course_author in course_data.get('course_authors'):
            author_name = course_author.get('name')
            picture_path = course_author.pop('picture')
            if picture_path and author_name:
                picture_path = picture_path.split('/', 2)[-1]
                course_author_pictures[author_name] = picture_path

        # save course material images
        course_material = course_data.get('course_material')
        course_material_files = []
        if course_material:
            course_material_files = course_data['course_material'].pop('files')
            # course_material_files = course_material.pop('files')

        if course:
            course_serializer = CourseImportSerializer(course, data=course_data)
        else:
            course_serializer = CourseImportSerializer(data=course_data)

        if course_serializer.is_valid():

            course_obj = course_serializer.save()

            # save thumbnail and home thumbnail
            if course_thumbnail_path and course_thumbnail_path in file_names:
                course_thumbnail_file = import_file.extractfile(course_thumbnail_path)
                course_obj.thumbnail = DjangoFile(course_thumbnail_file)
            if course_home_thumbnail_path and course_home_thumbnail_path in file_names:
                course_home_thumbnail_file = import_file.extractfile(course_home_thumbnail_path)
                course_obj.home_thumbnail = DjangoFile(course_home_thumbnail_file)

            course_material_files_list = []
            for course_material_file in course_material_files:
                course_material_file_path = course_material_file.get('file')
                course_material_file_obj = import_file.extractfile(course_material_file_path)
                course_material_files_list.append(TimtecFile(file=DjangoFile(course_material_file_obj)))
            course_obj.course_material.files = course_material_files_list
            course_obj.course_material.text = course_material['text']
            course_obj.course_material.save()

            for course_author in course_obj.course_authors.all():
                picture_path = course_author_pictures.get(course_author.name)
                if picture_path and picture_path in file_names:
                    picture_file_obj = import_file.extractfile(picture_path)
                    course_author.picture = DjangoFile(picture_file_obj)
                    course_author.save()

            course_obj.save()

            return Response({'new_course_url': reverse_lazy('administration.edit_course',
                                                            kwargs={'course_id': course_serializer.object.id}),
                             })
        else:
            return Response({'error': 'invalid_file'})


class NewStudentsJocaView(AdminView):

    def dispatch(self, request, *args, **kwargs):
        response = super(NewStudentsJocaView, self).dispatch(
            request, *args, **kwargs)

        if not (request.user.is_superuser or self.object.get_professor_role(request.user) == 'coordinator'):
            if self.raise_exception:  # *and* if an exception was desired
                raise PermissionDenied  # return a forbidden response.

        return response

    def get_context_data(self, **kwargs):
        context = super(NewStudentsJocaView, self).get_context_data(**kwargs)

        one_week = timezone.now() - timedelta(days = 7)
        if 'init' not in context:
            context['init'] = one_week.strftime("%d/%m/%Y")
        if 'end' not in context:
            context['end'] = timezone.now().strftime("%d/%m/%Y")

        return context

    def post(self, request, *args, **kwargs):

        date_init = request.POST["date_init"]
        date_end = request.POST["date_end"]
        context = self.get_context_data(**kwargs)
        context['init'] = date_init
        context['end'] = date_end

        try:
            date_init = datetime.strptime(date_init, "%d/%m/%Y").date()
            times = time(0, 0, 0, tzinfo=timezone.get_current_timezone())
            date_init = datetime.combine(date_init, times)
        except:
            context['error_init'] = 'Data de início em formato incorreto'
            return self.render_to_response(context)

        try:
            date_end = datetime.strptime(date_end, "%d/%m/%Y").date()
            times = time(23, 59, 59, tzinfo=timezone.get_current_timezone())
            date_end = datetime.combine(date_end, times)
        except:
            context['error_end'] = 'Date de fim em formato incorreto'
            return self.render_to_response(context)

        if date_init > date_end:
            context['error_init'] = 'Data de início deve ser menor ou igual a date de fim'
            return self.render_to_response(context)


        students = [ cs.user for cs in CourseStudent.objects.filter(course__id=settings.JOCA_COURSE_ID, created_at__gt=date_init, created_at__lt=date_end) ]
        joca_students = [ ju.user for ju in JocaUser.objects.filter(user__in=students)]

        new_students = [ s for s in students if s not in joca_students]
        new_joca_students = [s for s in students if s in joca_students]

        response = HttpResponse(content_type='text/csv')
        response['Content-Disposition'] = 'attachment; filename="alunos.csv"'

        writer = csv.writer(response)
        writer.writerow(['Email', 'Joca'])
        for student in new_students:
            writer.writerow([student.email, 'N'])
        for student in new_joca_students:
            writer.writerow([student.email, 'S'])

        return response
