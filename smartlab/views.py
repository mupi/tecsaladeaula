from django.shortcuts import render
from django.conf import settings
from django.core.urlresolvers import reverse_lazy

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

        course = Course.objects.get(id=settings.SMARTLAB_COURSE_ID)
        context['next'] = reverse_lazy('course_intro', args=[course.slug])

        return context

    def get_success_url(self):
        try:
            if ('email' in self.request.POST):
                user = TimtecUser.objects.get(email = self.request.POST['email'])
            else:
                user = self.request.user

            course = Course.objects.get(id=settings.SMARTLAB_COURSE_ID)
            
            if not course.is_enrolled(user):
                course.enroll_student(user)
            return reverse_lazy('course_intro', args=[course.slug])
        except:
            return reverse_lazy('courses')
