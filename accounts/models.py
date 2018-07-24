# -*- coding: utf-8 -*-

from django.db import models
from django.utils.translation import ugettext_lazy as _
from django.core import validators
from django.core.mail import send_mail
from django.conf import settings
from django.contrib.auth.models import AbstractBaseUser, PermissionsMixin, UserManager, Group
from django.utils import timezone

from core.utils import hash_name
import re


class AbstractTimtecUser(AbstractBaseUser, PermissionsMixin):
    USERNAME_REGEXP = re.compile('^[\w.+-@]+$')
    username = models.CharField(
        _('Username'), max_length=100, unique=True,
        help_text=_('Required. 30 characters or fewer. Letters, numbers and '
                    './+/-/_ characters'),
        validators=[
            validators.RegexValidator(USERNAME_REGEXP, _('Enter a valid username.'), 'invalid')
        ])

    first_name = models.CharField(_('First name'), max_length=60, blank=True)
    last_name = models.CharField(_('Last name'), max_length=60, blank=True)
    is_staff = models.BooleanField(_('Staff status'), default=False)
    is_active = models.BooleanField(_('Active'), default=True)
    date_joined = models.DateTimeField(_('Date joined'), default=timezone.now)

    picture = models.ImageField(_("Picture"), upload_to=hash_name('user-pictures', 'username'), blank=True)
    occupation = models.CharField(_('Occupation'), max_length=30, blank=True)
    site = models.URLField(_('Site'), blank=True)
    biography = models.TextField(_('Biography'), blank=True)
    accepted_terms = models.BooleanField(_('Accepted terms and condition'), default=False)

    objects = UserManager()

    USERNAME_FIELD = 'username'
    REQUIRED_FIELDS = ['email']

    class Meta:
        verbose_name = _('user')
        verbose_name_plural = _('users')
        abstract = True

    def __unicode__(self):
        if self.first_name or self.last_name:
            return self.get_full_name()
        return self.email

    def get_picture_url(self):
        if not self.picture:
            location = "/%s/%s" % (settings.STATIC_URL, 'img/avatar-default.png')
        else:
            location = "/%s/%s" % (settings.MEDIA_URL, self.picture)
        return re.sub('/+', '/', location)

    def get_full_name(self):
        return self.first_name.strip()

    def get_short_name(self):
        return self.first_name

    def email_user(self, subject, message, from_email=None):
        send_mail(subject, message, from_email, [self.email])

    def get_user_type(self):
        if self.is_superuser:
            return "superuser"
        elif self.groups.filter(name='professors').count():
            return "professors"
        elif self.groups.filter(name='students').count():
            return "students"
        return "unidentified"

    def is_pilot(self):
        return self.groups.filter(name='pilot_course').count() > 0

    def save(self, *args, **kwargs):
        self.username = self.email
        is_new = self.pk is None

        super(AbstractTimtecUser, self).save(*args, **kwargs)

        if is_new and settings.REGISTRATION_DEFAULT_GROUP_NAME:
            try:
                self.groups.add(Group.objects.get(name=settings.REGISTRATION_DEFAULT_GROUP_NAME))
                self.save()
            except models.exceptions.ObjectDoesNotExist:
                pass


#populated by fixture
class State (models.Model):
    uf = models.CharField(max_length=2, primary_key=True)
    name = models.CharField(max_length=50)
    uf_code = models.CharField(max_length=5)

#populated by fixture
class City (models.Model):
    code = models.CharField(max_length=10)
    name = models.CharField(max_length=80)
    uf = models.ForeignKey(State, on_delete=models.CASCADE)

    def __unicode__(self):
        return self.uf.uf + " " + self.name

class Occupation(models.Model):
    name = models.CharField(max_length=100)

    def __unicode__(self):
        return self.name

#populated by fixture
class Discipline (models.Model):
    name = models.CharField(max_length=100, unique=True)
    visible = models.BooleanField(default=False)

    def __unicode__(self):
        return self.name

class EducationLevel(models.Model):
    slug = models.CharField(max_length=3, primary_key=True)
    name = models.CharField(max_length=50)

    def __unicode__(self):
        return self.name

class EducationDegree (models.Model):
    name = models.CharField(max_length=50, unique=True)
    education_level = models.ForeignKey(EducationLevel)

    def __unicode__(self):
            return self.name

class School (models.Model):
    SCHOOL_TYPES = [
        ('PU','Pública'),
        ('PR','Privada'),
        ('AP','Autônomo/Particular'),
        ('OU','Outra')
    ]
    name = models.CharField(max_length=200, blank=False, null=False)
    school_type = models.CharField(max_length=2, choices=SCHOOL_TYPES, blank=False, null=False)

    def __unicode__(self):
        return self.name

class TimtecUser(AbstractTimtecUser):
    """
    Timtec customized user.

    Username, password and email are required. Other fields are optional.
    """
    business_email = models.EmailField(blank=True, null=True)
    email = models.EmailField(_('Email address'), blank=False, unique=True)
    schools = models.ManyToManyField(School, through='TimtecUserSchool', blank=True, null=True)
    disciplines = models.ManyToManyField(Discipline, blank=True, null=True)
    city = models.ForeignKey(City, on_delete=models.CASCADE, null=True, blank=True)
    occupations = models.ManyToManyField(Occupation, blank=True, null=True)
    education_levels = models.ManyToManyField(EducationLevel, blank=True, null=True)

    class Meta(AbstractTimtecUser.Meta):
        swappable = 'AUTH_USER_MODEL'

    @property
    def is_profile_complete(self):
        if self.first_name and len(self.first_name) > 3 and self.occupations.count() > 0 and self.city and self.biography and len(self.biography) > 3:
            return True
        return False

class TimtecUserSchool(models.Model):
    professor = models.ForeignKey(TimtecUser)
    school = models.ForeignKey(School)

    def __unicode__(self):
        return self.professor.username + " " + self.school.name