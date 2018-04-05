# -*- coding: utf-8 -*-
import datetime
from django.contrib.auth import get_user_model
from django import forms
from django.utils.translation import ugettext_lazy as _
from django.conf import settings
from django.core.mail import send_mail
from django.template.loader import get_template
from django.template import Context

from allauth.account.forms import SignupForm

User = get_user_model()

from .models import School, City, Occupation

class MultipleChoiceFieldNoValidation(forms.MultipleChoiceField):
    def validate(self, value):
        pass

class ProfileEditForm(forms.ModelForm):

    class Meta:
        model = User
        fields = ('first_name', 'city', 'occupations', 'picture', 'site', 'biography',)


    def save(self, commit=True):
        return super(ProfileEditForm, self).save(commit=commit)


class ProfilePasswordForm(forms.ModelForm):
    email = forms.RegexField(label=_("email"), max_length=75, regex=r"^[\w.@+-]+$")
    password1 = forms.CharField(widget=forms.PasswordInput, label=_("Password"), required=False)
    password2 = forms.CharField(widget=forms.PasswordInput, label=_("Password (again)"), required=False)

    class Meta:
        model = User
        fields = ('email',)

    def clean_password2(self):
        password1 = self.cleaned_data.get('password1')
        password2 = self.cleaned_data.get('password2')
        if password1 and password2:
            if password1 != password2:
                raise forms.ValidationError(_("The two password fields didn't match."))
        return password2

    def save(self, commit=True):
        if self.cleaned_data['password1']:
            self.instance.set_password(self.cleaned_data['password1'])
        return super(ProfileEditForm, self).save(commit=commit)

class SchoolAddForm(forms.ModelForm):

    class Meta:
        model = School

class AcceptTermsForm(forms.Form):
    accept_terms = forms.BooleanField(label=_('Eu aceito os termos de uso'), initial=False, required=False)

    def clean_accept_terms(self):
        data = self.cleaned_data['accept_terms']
        if settings.TERMS_ACCEPTANCE_REQUIRED and not data:
                raise forms.ValidationError(_('You must agree to the Terms of Use to use %(site_name)s.'),
                                            params={'site_name': settings.SITE_NAME},)
        return self.cleaned_data['accept_terms']


class SignupForm(SignupForm, AcceptTermsForm):
    fullname = forms.CharField(label=_("Nome Completo"),initial=False,required=True)

    def extract_first_name(self,name):
        names = name.split(" ")
        return names[0]

    def extract_last_name(self, name):
        names = name.split(" ")
        if len(names) > 1:
            return " ".join(names[1:])
        else:
            return ""

    def clean_full_name(self):
        data  = self.cleaned_data['fullname']
        if not data.strip():
            raise forms.ValidationError(_('You Must fill your complete name'))
        return data

    def save(self, request):
        user = super(SignupForm, self).save(request)
        name = self.cleaned_data['fullname']
        user.accepted_terms = self.cleaned_data['accept_terms']
        user.first_name = self.extract_first_name(name)
        user.last_name = self.extract_last_name(name)
        user.save()
        return user
        # send_mail('Novo Usuário Cadastrado', get_template('account/email/email_new_user_message.txt').render(Context({'date': now.strftime("%d/%m/%Y"), 'time': now.strftime("%H:%M"), 'username': username, 'email': email})), settings.EMAIL_SUPPORT, [settings.EMAIL_SUPPORT])
