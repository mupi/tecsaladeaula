# -*- coding: utf-8 -*-
from __future__ import division

from django.utils.translation import ugettext_lazy as _
from django.db import models
from django.conf import settings

class JocaUser(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, verbose_name=_('User'))
