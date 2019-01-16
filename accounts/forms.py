# -*- coding: utf-8 -*-
import datetime
from django.contrib.auth import get_user_model
from django import forms
from django.utils.translation import ugettext_lazy as _
from django.conf import settings
from django.core.mail import send_mail
from django.template.loader import get_template
from django.template import Context
from django.contrib.auth.forms import (UserCreationForm, UserChangeForm,)
from allauth.account.forms import SignupForm

User = get_user_model()

from .models import School, City, Occupation, Discipline, EducationLevel

class MultipleChoiceFieldNoValidation(forms.MultipleChoiceField):
    def validate(self, value):
        pass

class ProfileEditForm(forms.ModelForm):
    disciplines = MultipleChoiceFieldNoValidation()
    education_levels = MultipleChoiceFieldNoValidation()

    class Meta:
        model = User
        fields = ('picture', 'first_name', 'occupations','city', 'site', 'biography', 'cpf', 'rg', 'phone')

    def clean_cpf(self):
        cpf=self.cleaned_data['cpf']
        cpf = cpf.replace('.', '')
        digits = cpf.split('-')
        soma = 0
        all_eq = True
        
        if len(cpf) == 0:
            return None
    
        for d in cpf.replace('-', ''):
            if d != cpf[0]:
                all_eq = False
                break
          
        if all_eq:
            raise forms.ValidationError(_("CPF invalido!"))      

        for i in range(len(digits[0])):
            soma = soma + (10-i) * int(digits[0][i])
        
        res = (soma*10)%11 
        
        if res %10 != int(digits[1][0]):
             raise forms.ValidationError(_("CPF invalido!"))
        
        soma = 0
            
        for i in range(len(digits[0])):
            soma = soma + (11-i) * int(digits[0][i])
        
        soma = soma + 2 * int(digits[1][0]) 

        res = (soma*10)%11    
       
        if res  %10 != int(digits[1][1]):
             raise forms.ValidationError(_("CPF invalido!"))

        return self.cleaned_data['cpf']


    def save(self, commit=True):
        disciplines = self.cleaned_data.get('disciplines')
        education_levels = self.cleaned_data.get('education_levels')
        profile = super(ProfileEditForm, self).save(commit=False)
        
        saved_disciplines = profile.disciplines.all()
        saving_disciplines = []
        for d in disciplines:
            if (not Discipline.objects.filter(name=d).exists()):
                new_d = Discipline.objects.create(name=d)
                new_d.save()
                saving_disciplines.append(new_d)
            else:
                saving_disciplines.append(Discipline.objects.get(name=d))
        to_save = [d for d in saving_disciplines if d not in saved_disciplines]
        for d in to_save:
            profile.disciplines.add(d)
        to_remove = [d for d in saved_disciplines if d not in saving_disciplines]
        for d in to_remove:
            profile.disciplines.remove(d)

        saved_education_levels = profile.education_levels.all()
        saving_education_levels = []
        for el in education_levels:
            saving_education_levels.append(EducationLevel.objects.get(slug=el))
        to_save = [el for el in saving_education_levels if el not in saved_education_levels]
        for el in to_save:
            profile.education_levels.add(el)
        to_remove = [el for el in saved_education_levels if el not in saving_education_levels]
        for el in to_remove:
            profile.education_levels.remove(el)
              
        self.save_m2m()
        profile.save()

        


class ProfilePasswordForm(forms.ModelForm):
    # email = forms.RegexField(max_length=75, regex=r"^[\w.@+-]+$")
    business_email = forms.RegexField(max_length=75, regex=r"^[\w.@+-]+$", required=False)
    password1 = forms.CharField(widget=forms.PasswordInput, required=False)
    password2 = forms.CharField(widget=forms.PasswordInput, required=False)

    class Meta:
        model = User
        fields = ('business_email',)

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
        return super(ProfilePasswordForm, self).save(commit=commit)

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
    username = forms.CharField(initial=False,required=False)
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

    def clean_username(self):
        return self.data['email']

    def clean_fullname(self):
        data = self.cleaned_data['fullname']
        if not data.strip():
            raise forms.ValidationError(_('You Must fill your complete name'))
        return data

    def save(self, request):
        user = super(SignupForm, self).save(request)
        name = self.cleaned_data['fullname']
        user.accepted_terms = self.cleaned_data['accept_terms']
        user.first_name = name
        # user.first_name = self.extract_first_name(name)
        # user.last_name = self.extract_last_name(name)
        user.save()
        return user
        # send_mail('Novo Usuário Cadastrado', get_template('account/email/email_new_user_message.txt').render(Context(
            # {'date': now.strftime("%d/%m/%Y"), 'time': now.strftime("%H:%M"), 'username': username, 'email': email})), settings.EMAIL_SUPPORT, [settings.EMAIL_SUPPORT])

class NewUserCreationForm(UserCreationForm):
    username = forms.RegexField(label=_("Username"), max_length=75,
    regex=r'^[\w.@+-]+$',
    help_text=_("Required. 75 characters or fewer. Letters, digits and "
                    "@/./+/-/_ only."),
    error_messages={
        'invalid': _("This value may contain only letters, numbers and "
                        "@/./+/-/_ characters.")})

class NewUserChangeForm(UserChangeForm):
    username = forms.RegexField(label=_("Username"), max_length=75,
    regex=r'^[\w.@+-]+$',
    help_text=_("Required. 75 characters or fewer. Letters, digits and "
                    "@/./+/-/_ only."),
    error_messages={
        'invalid': _("This value may contain only letters, numbers and "
                        "@/./+/-/_ characters.")})