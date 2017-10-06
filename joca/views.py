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

    def get_context_data(self, **kwargs):
        context = super(JocaSignupView, self).get_context_data(**kwargs)

        course = Course.objects.get(id=11)
        context['next'] = reverse_lazy('course_intro', args=[course.slug])

        return context

    def get_success_url(self):
        try:
            if ('email' in self.request.POST):
                user = TimtecUser.objects.get(email = self.request.POST['email'])
            else:
                user = self.request.user

            course = Course.objects.get(id=11)
            if not course.is_enrolled(user):
                course.enroll_student(user)
            return reverse_lazy('course_intro', args=[course.slug])
        except:
            return reverse_lazy('courses')
