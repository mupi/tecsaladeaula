from django.shortcuts import render
from django.conf import settings
from django.core.urlresolvers import reverse_lazy
from django.views.generic import ListView

from core.models import Course
from accounts.models import TimtecUser

from allauth.account.views import SignupView
from accounts.forms import SignupForm

class SmartlabSignupView(SignupView):

    template_name = 'smartlab/smartlab_signup.html'
    form_class = SignupForm
    redirect_field_name = 'next'
    view_name = 'smartlab_signup'

    def get_context_data(self, **kwargs):
        context = super(SmartlabSignupView, self).get_context_data(**kwargs)

        context['next'] = reverse_lazy('smartlab_courses')

        return context

    def get_success_url(self):
        try:
            if ('email' in self.request.POST):
                user = TimtecUser.objects.get(email = self.request.POST['email'])
            else:
                user = self.request.user
            for course_id in settings.SMARTLAB_COURSE_ID:
                course = Course.objects.get(id=course_id)
                if not course.is_enrolled(user):
                    course.enroll_student(user)
            return reverse_lazy('smartlab_courses')
        except:
            return reverse_lazy('smartlab_courses')   

class CoursesView(ListView):
    context_object_name = 'courses'
    template_name = "courses.html"

    def get_queryset(self):
        return Course.objects.filter(id__in=settings.SMARTLAB_COURSE_ID).order_by('start_date')
