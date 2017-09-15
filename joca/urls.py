from django.conf.urls import  url

from . import views


urlpatterns = [
    url(r'^signup/?$', views.JocaSignupView.as_view(), name='joca_signup'),
]
