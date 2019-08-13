# -*- coding: utf-8 -*-
from __future__ import division
from rest_framework import viewsets
from rest_framework.response import Response
from braces.views import LoginRequiredMixin
from django.core.paginator import Paginator, PageNotAnInteger, EmptyPage
from django.core.exceptions import ObjectDoesNotExist
from django.db.models import Q
from reports.serializer import PaginatedUserCourseStatsSerializer, CourseStats, LessonUserStats

from django.utils import timezone
from datetime import datetime, date, time, timedelta
from django.utils import timezone

from core.models import Course, CourseStudent, Class, StudentProgress
from core.permissions import IsAdmin


class UserCourseStats(LoginRequiredMixin, viewsets.ReadOnlyModelViewSet):
    model = CourseStudent
    serializer_class = PaginatedUserCourseStatsSerializer
    permission_classes = (IsAdmin, )

    def get_queryset(self):
        queryset = super(UserCourseStats, self).get_queryset()
        user = self.request.user
        course_id = self.request.QUERY_PARAMS.get('course')
        keyword = self.request.QUERY_PARAMS.get('keyword')
        from_date = self.request.QUERY_PARAMS.get('from_date')
        until_date = self.request.QUERY_PARAMS.get('until_date')

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

        return queryset

    def list(self, request):
        percentage_completion = self.request.QUERY_PARAMS.get('percentage_completion')
        days_inactive = self.request.QUERY_PARAMS.get('days_inactive')
        page = request.QUERY_PARAMS.get('page')

        course_students = [cs for cs in self.get_queryset()]
        
        course = Course.objects.get(id=self.request.QUERY_PARAMS.get('course'))
        unit_count = course.unit_set.count()
        all_units_dones = StudentProgress.objects.exclude(complete=None)\
                                .filter(unit__lesson__course=course)\
                                .select_related('user')

        all_units_counts_user = {}
        for unit_done in all_units_dones:
            user_id = unit_done.user_id

            if user_id in all_units_counts_user:
                all_units_counts_user[user_id] += 1
            else:
                all_units_counts_user[user_id] = 1
        progresses = {}
        for cs in course_students:
            units_done_len = all_units_counts_user.get(cs.user_id, 0)
            progresses[cs.user_id] = int(units_done_len / unit_count * 100)

        if percentage_completion:
            if percentage_completion == '1':
                course_students = [cs for cs in course_students if progresses.get(cs.user_id, 0) == 0]
            elif percentage_completion == '2':
                course_students = [cs for cs in course_students if progresses.get(cs.user_id, 0) > 0 and progresses.get(cs.user_id, 0) < 50]
            elif percentage_completion == '3':
                course_students = [cs for cs in course_students if progresses.get(cs.user_id, 0) >= 50 and progresses.get(cs.user_id, 0) < 80]
            elif percentage_completion == '4':
                course_students = [cs for cs in course_students if progresses.get(cs.user_id, 0) >= 80]

        if days_inactive:
            days_inactive = int(days_inactive)
            from_date = datetime.now() - timedelta(days=days_inactive)
            t = time(0, 0, 0, tzinfo=timezone.get_current_timezone())
            from_date = datetime.combine(from_date.date(), t)
            course_students = [cs for cs in course_students if cs.get_last_access() == None or cs.get_last_access() <= from_date]

        paginator = Paginator(course_students, 50)
        try:
            course_students = paginator.page(page)
        except PageNotAnInteger:
            course_students = paginator.page(1)
        except EmptyPage:
            course_students = paginator.page(paginator.num_pages)

        serializer_context = {'request': request}
        serializer = PaginatedUserCourseStatsSerializer(course_students, context=serializer_context)
        return Response(serializer.data)

    

class UserCourseLessonsStats(LoginRequiredMixin, viewsets.ReadOnlyModelViewSet):
    model = CourseStudent
    serializer_class = LessonUserStats
    filter_fields = ('course', 'user',)
    lookup_field = 'course'


class CourseStatsByLessonViewSet(LoginRequiredMixin, viewsets.ReadOnlyModelViewSet):
    model = Course
    serializer_class = CourseStats

    def retrieve(self, request, *args, **kwargs):
        self.object = self.get_object()

        course_id = self.kwargs.get('pk')
        role = None
        try:
            role = self.request.user.teaching_courses.get(course__id=course_id).role
        except ObjectDoesNotExist:
            pass

        classes_id = self.request.QUERY_PARAMS.getlist('classes')
        # class passed as get paremeter
        classes = Class.objects.filter(course=course_id)
        if classes_id:
            classes = classes.filter(id__in=classes_id)
        # if user is not coordinator or admin, only show his classes
        if not (role and (role == 'coordinator') and self.request.user.is_staff and self.request.user.is_superuser):
            classes = classes.filter(assistant=self.request.user)

        self.object.classes = classes
        serializer = self.get_serializer(self.object)
        return Response(serializer.data)
