from django.conf.urls import  url

from . import views


urlpatterns = [
    url(r'^signup/?$', views.SmartlabSignupView.as_view(), name='smartlab_signup'),
]
