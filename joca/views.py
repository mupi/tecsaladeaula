from django.shortcuts import render

# Create your views here.
from allauth.account.views import SignupView

from .forms import JocaSignupForm

class JocaSignupView(SignupView):

    template_name = 'joca/joca_signup.html'
    form_class = JocaSignupForm
    redirect_field_name = 'next'
    view_name = 'joca_signup'

    # def post(self, request):
    #     form = JocaSignupForm(request.POST)
    #     form.data["username"] = form.data["email"]
    #     request.POST = form
    #     print form.data["email"]
    #     print request
    #     resp = super(JocaSignupView, self).post(request)
    #     return resp

    # def get_context_data(self, **kwargs):
    #     form = kwargs['form']
    #     form.fields["username"] = form.fields["email"]
    #     print form.fields["username"]
    #     print form.fields["email"]
    #     kwargs['form'] = form
    #     ret = super(JocaSignupView, self).get_context_data(**kwargs)
    #     ret.update(self.kwargs)
    #     print ret
    #     return ret
