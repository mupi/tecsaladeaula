# -*- coding: utf-8 -*-
# configurations for the production server
# https://docs.djangoproject.com/en/dev/ref/settings/
DEBUG = False
TEMPLATE_DEBUG = DEBUG

TIMTEC_THEME = 'tecsaladeaula'

SITE_HOME = '/'
SITE_DOMAIN = 'teste.tecsaladeaula.com.br'
SITE_URL = 'https://teste.tecsaladeaula.com.br'
ALLOWED_HOSTS = [
    'teste.tecsaladeaula.com.br',
]

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'timtec-production',
        'USER': 'timtec-production',
    }
}

MEDIA_ROOT = "/home/testec/webfiles/media/"
STATIC_ROOT = "/home/testec/webfiles/static/"

EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
EMAIL_SUBJECT_PREFIX = '[tecsaladeaula]'
DEFAULT_FROM_EMAIL = 'suporte@mupi.me'
CONTACT_RECIPIENT_LIST = ['suporte@mupi.me', ]

# COLOCAR SENHA
EMAIL_HOST = 'smtp.gmail.com'
EMAIL_HOST_USER = 'contato@mupi.me'
EMAIL_HOST_PASSWORD = 
EMAIL_PORT = 587
EMAIL_USE_TLS = True

ACCOUNT_EMAIL_VERIFICATION = 'optional'

LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'filters': {
        'require_debug_false': {
            '()': 'django.utils.log.RequireDebugFalse'
        }
    },
    'formatters': {
        'verbose': {
            'format': '%(levelname)s %(asctime)s %(module)s %(process)d %(thread)d %(message)s'
        },
    },
    'handlers': {
        'mail_admins': {
            'level': 'ERROR',
            'filters': ['require_debug_false'],
            'class': 'django.utils.log.AdminEmailHandler'
        },
        'logfile': {
            'level': 'WARN',
            'class': 'logging.handlers.RotatingFileHandler',
            'filename': '/home/testec/django.log',
            'maxBytes': 50000,
            'backupCount': 2,
            'formatter': 'verbose',
        },
    },
    'loggers': {
        'django': {
            'handlers': ['logfile'],
            'propagate': True,
            'level': 'WARN',
        },
        'django.request': {
            'handlers': ['mail_admins'],
            'level': 'ERROR',
            'propagate': True,
        },
    }
}

# SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')

# SECURITY CONFIGURATION
# ------------------------------------------------------------------------------
# See https://docs.djangoproject.com/en/1.9/ref/middleware/#module-django.middleware.security
# and https://docs.djangoproject.com/ja/1.9/howto/deployment/checklist/#run-manage-py-check-deploy

# set this to 60 seconds and then to 518400 when you can prove it works
# SECURE_HSTS_SECONDS = 60
# SECURE_HSTS_INCLUDE_SUBDOMAINS =True
# SECURE_CONTENT_TYPE_NOSNIFF = True
# SECURE_BROWSER_XSS_FILTER = True
# SESSION_COOKIE_SECURE = True
# SESSION_COOKIE_HTTPONLY = True
# SECURE_SSL_REDIRECT = True
# CSRF_COOKIE_SECURE = True
# CSRF_COOKIE_HTTPONLY = False
# X_FRAME_OPTIONS = 'DENY'

try:
    # THIS FILE SETS PRODUCTION SPECIFIC
    # SENSITIVY VALUES (SUCH AS GOOGLE ANALYTICS KEY)
    from .settings_production import *
except ImportError:
    pass
