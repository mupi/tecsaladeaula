from django.contrib import admin
from activities.admin import ModelAdmin

from .models import JocaUser


class JocaUserAdmin(ModelAdmin):
    model = JocaUser

    search_fields = ('user__username',)
    list_display = ('user',)

admin.site.register(JocaUser, JocaUserAdmin)
