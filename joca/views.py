from django.shortcuts import render
from django.core.urlresolvers import reverse_lazy

from core.models import Course
from accounts.models import TimtecUser

from allauth.account.views import SignupView

from .forms import JocaSignupForm

class JocaSignupView(SignupView):

    template_name = 'joca/joca_signup.html'
    form_class = JocaSignupForm
    redirect_field_name = 'next'
    view_name = 'joca_signup'

    def get_success_url(self):
        try:
            user = TimtecUser.objects.get(email = self.request.POST['email'])

            course = Course.objects.get(id=11)
            course.enroll_student(user)
            if course.has_started and course.first_lesson():
                return reverse_lazy('course_intro', args=[course.slug])
        except:
            return reverse_lazy('courses')
