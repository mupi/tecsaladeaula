from django.conf.urls import  url

from . import views


urlpatterns = [
    url(r'^signup/?$', views.SmartlabSignupView.as_view(), name='smartlab_signup'),
    url(r'^courses/?$', views.CoursesView.as_view(), name='smartlab_courses'),
]
