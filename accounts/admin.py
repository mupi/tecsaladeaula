# -*- coding: utf-8 -*-

from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from django.contrib.auth import get_user_model
from django.utils.translation import ugettext_lazy as _

from .forms import NewUserCreationForm, NewUserChangeForm
from .models import School, TimtecUserSchool

User = get_user_model()


class TimtecUserAdmin(UserAdmin):
    model = User
    fieldsets = UserAdmin.fieldsets + (
        (_('Timtec Info'), {'fields': ('business_email','accepted_terms', 'picture', 'disciplines', 'city', 'occupations')}),
    )
    form = NewUserChangeForm
    add_form = NewUserCreationForm
    filter_horizontal = ('disciplines', 'occupations', 'groups', 'user_permissions',)

class SchoolAdmin(admin.ModelAdmin):
    model = School

class UserSchoolAdmin(admin.ModelAdmin):
    model = TimtecUserSchool


admin.site.register(User, TimtecUserAdmin)
admin.site.register(School, SchoolAdmin)
admin.site.register(TimtecUserSchool, UserSchoolAdmin)
