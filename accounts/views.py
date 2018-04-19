from django.contrib.auth import get_user_model
from django.core.paginator import Paginator, PageNotAnInteger, EmptyPage
from django.core.urlresolvers import reverse_lazy
from django.shortcuts import get_object_or_404
from django.views.generic import UpdateView, FormView
from django.views.generic.detail import DetailView
from django.db.models import Q

from accounts.forms import ProfileEditForm, AcceptTermsForm
from accounts.serializers import    (TimtecUserSerializer, TimtecUserAdminSerializer, CitySerializer,
                                    TimtecProfileSerializer, OccupationSerializer, DisciplineSerializer,
                                    EducationDegreeSerializer, EducationLevelSerializer, SchoolSerializer)
from allauth.account.views import SignupView
from braces.views import LoginRequiredMixin

from rest_framework import viewsets, filters, generics, permissions, mixins, status, serializers
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response

from core.permissions import IsAdmin

from .forms import SignupForm, ProfilePasswordForm
from .permissions import IsProfessorOrReadOnly
from .models import State, City, Occupation, Discipline, School, EducationDegree, EducationLevel, TimtecUserSchool
from .serializers import SchoolSerializer, TimtecUserSchoolSerializer, TimtecProfileSchoolSerializer
import json


class ProfileEditView(LoginRequiredMixin, UpdateView):
    model = get_user_model()
    form_class = ProfileEditForm
    template_name = 'profile-edit.html'

    def get_success_url(self):
        return reverse_lazy('profile')

    def get_object(self):
        return self.request.user

    def get_context_data(self, **kwargs):
        context = super(ProfileEditView, self).get_context_data(**kwargs)
        data = {'email' : self.request.user.email, 'business_email': self.request.user.business_email}
        form  = ProfilePasswordForm(initial=data)
        context['form_email_password'] = form
        return context

class ProfileEmailPasswordEditView(LoginRequiredMixin, UpdateView):
    model = get_user_model()
    form_class = ProfilePasswordForm
    template_name = 'profile-edit.html'

    def get_success_url(self):
        return reverse_lazy('profile')

    def get_object(self):
        return self.request.user

    def get_context_data(self, **kwargs):
        context = super(ProfileEmailPasswordEditView, self).get_context_data(**kwargs)
        data = {'email' : self.request.user.email, 'business_email': self.request.user.business_email}
        form  = ProfilePasswordForm(initial=data)
        context['form_email_password'] = form
        context['account_pane'] = True
        return context

class TimtecUserSchoolViewSet(LoginRequiredMixin, viewsets.ModelViewSet):
    queryset = TimtecUserSchool.objects.all()
    serializer_class = TimtecUserSchoolSerializer
    permission_classes = (IsProfessorOrReadOnly, )

    def create(self, request, *args, **kwargs):
        data = request.DATA
        data['professor'] = self.request.user.id
        serializer = self.get_serializer(data=request.DATA, files=request.FILES)

        if serializer.is_valid():
            self.pre_save(serializer.object)
            self.object = serializer.save(force_insert=True)
            self.post_save(self.object, created=True)
            headers = self.get_success_headers(serializer.data)
            return Response(serializer.data, status=status.HTTP_201_CREATED,
                            headers=headers)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def get_serializer_class(self):
        print(self.action)
        if self.action == 'retrieve':
            return TimtecProfileSchoolSerializer
        return TimtecUserSchoolSerializer

    def destroy(self, request, pk=None):
        school = TimtecUserSchool.objects.get(id = pk).school
        response = super(TimtecUserSchoolViewSet, self).destroy(request, pk)
        school.delete()
        return response

class ProfileView(LoginRequiredMixin, DetailView):
    model = get_user_model()
    template_name = 'profile.html'
    context_object_name = 'profile_user'

    def get_object(self):
        if hasattr(self, 'kwargs') and 'username' in self.kwargs:
            try:
                return get_object_or_404(self.model, username=self.kwargs['username'])
            except:
                return self.request.user
        else:
            return self.request.user


class TimtecUserViewSet(viewsets.ReadOnlyModelViewSet):
    model = get_user_model()
    lookup_field = 'id'
    filter_fields = ('groups__name',)
    filter_backends = (filters.DjangoFilterBackend, filters.OrderingFilter,)
    serializer_class = TimtecUserSerializer
    ordering = ('first_name', 'username',)


class TimtecUserAdminViewSet(viewsets.ModelViewSet):
    model = get_user_model()
    permission_classes = (IsAdmin, )
    serializer_class = TimtecUserAdminSerializer
    paginate_by_param = 'page_size'
    paginate_by = 50

    def get_queryset(self):
        page = self.request.GET.get('page')
        keyword = self.request.GET.get('keyword')
        admin = self.request.GET.get('admin')
        blocked = self.request.GET.get('blocked')
        uf = self.request.GET.get('uf')
        city = self.request.GET.get('city')
        education_degrees = self.request.GET.getlist('education_degrees')
        occupations = self.request.GET.getlist('occupations')
        disciplines = self.request.GET.getlist('disciplines')
        queryset = super(TimtecUserAdminViewSet, self).get_queryset().order_by('username')

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
            queryset = queryset.filter(disciplines__in=disciplines).distinct()

        if education_degrees:
            queryset = queryset.filter(education_degrees__in=education_degrees).distinct()

        if uf:
            queryset = queryset.filter(city__uf=uf)
        if city:
            queryset = queryset.filter(city__id=city)


        return queryset


class UserSearchView(LoginRequiredMixin, generics.ListAPIView):
    model = get_user_model()
    serializer_class = TimtecUserSerializer

    def get_queryset(self):
        queryset = self.model.objects.all()
        query = self.request.QUERY_PARAMS.get('name', None)
        if query is not None:
            queryset = queryset.filter(Q(first_name__icontains=query) |
                                       Q(last_name__icontains=query) |
                                       Q(username__icontains=query) |
                                       Q(email__icontains=query))
        return queryset


class StudentSearchView(LoginRequiredMixin, generics.ListAPIView):
    model = get_user_model()
    serializer_class = TimtecUserSerializer
    search_fields = ('first_name', 'last_name', 'username', 'email')

    def get_queryset(self):
        queryset = self.model.objects.all()
        course = self.request.QUERY_PARAMS.get('course', None)

        classes = self.request.user.professor_classes.all()

        if classes:
            queryset = queryset.filter(classes__in=classes)
        else:
            # FIXME: if every student is in a class, this is useless.
            if course is not None:
                queryset = queryset.filter(studentcourse_set=course)
        query = self.request.QUERY_PARAMS.get('name', None)
        if query is not None:
            queryset = queryset.filter(Q(first_name__icontains=query) |
                                       Q(last_name__icontains=query) |
                                       Q(username__icontains=query) |
                                       Q(email__icontains=query))
        return queryset


class AcceptTermsView(FormView):
    template_name = 'accept-terms.html'
    form_class = AcceptTermsForm
    success_url = reverse_lazy('courses')

    def get_success_url(self):
        next_url = self.request.POST.get('next', None)
        if next_url:
            return next_url
        return reverse_lazy('courses')

    def form_valid(self, form):
        # This method is called when valid form data has been POSTed.
        # It should return an HttpResponse.
        self.request.user.accepted_terms = True
        self.request.user.save()
        return super(AcceptTermsView, self).form_valid(form)

    def get_context_data(self, **kwargs):
        context = super(AcceptTermsView, self).get_context_data(**kwargs)

        next_url = self.request.GET.get('next')
        if next_url:
            context['next_url'] = next_url
        return context

class SignupView(SignupView):
    template_name = 'account/signup.html'
    form_class = SignupForm
    view_name = 'signup_view'

class SchoolViewSet(LoginRequiredMixin, viewsets.ModelViewSet):
    queryset = School.objects.all()
    serializer_class = SchoolSerializer
    permission_classes = (IsProfessorOrReadOnly, )

@api_view(['GET'])
@permission_classes((permissions.AllowAny,))
def list_occupations_view(request):
    occupations = [OccupationSerializer(o).data for o in Occupation.objects.all()]
    return Response(occupations)

@api_view(['GET'])
@permission_classes((permissions.AllowAny,))
def list_disciplines_view(request):
    disciplines = [DisciplineSerializer(d).data for d in Discipline.objects.filter(visible=True)]
    return Response(disciplines)

@api_view(['GET'])
@permission_classes((permissions.AllowAny,))
def list_educationdegrees_view(request):
    educationdegrees = [EducationDegreeSerializer(ed).data for ed in EducationDegree.objects.all()]
    return Response(educationdegrees)

@api_view(['GET'])
@permission_classes((permissions.AllowAny,))
def list_educationlevels_view(request):
    educationlevels = [EducationLevelSerializer(el).data for el in EducationLevel.objects.all()]
    return Response(educationlevels)

@api_view(['GET'])
@permission_classes((permissions.AllowAny,))
def list_schooltypes_view(request):
    schooltypes = [{'value': st[0], 'name': st[1]} for st in School.SCHOOL_TYPES]
    return Response(schooltypes)

@api_view(['GET'])
@permission_classes((permissions.AllowAny,))
def list_states_view(request):
    states = [s.uf for s in State.objects.all()]
    return Response(states)

@api_view(['GET'])
@permission_classes((permissions.AllowAny,))
def list_cities_view(request):
    uf = request.QUERY_PARAMS.get('uf')
    cities = [CitySerializer(c).data for c in City.objects.filter(uf=uf)]
    return Response(cities)

@api_view(['GET'])
@permission_classes((permissions.IsAuthenticated,))
def get_timtec_profile(request):
    user = TimtecProfileSerializer(request.user)
    return Response(user.data)