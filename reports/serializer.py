# -*- coding: utf-8 -*-
from rest_framework import serializers, pagination
from core.models import CourseStudent, Course

from accounts.serializers import TimtecProfileSerializer



class UserCourseStatsSerializer(serializers.ModelSerializer):

    user = TimtecProfileSerializer(required=False, read_only=True)
    course_progress = serializers.SerializerMethodField('get_user_progress')
    last_access = serializers.SerializerMethodField('get_last_access')

    class Meta:
        model = CourseStudent
        fields = ('user', 'course_progress', 'created_at', 'last_access', 'status')

    def get_user_progress(self, obj):
        return obj.percent_progress()

    def get_last_access(self, obj):
        return obj.get_last_access()

class PaginatedUserCourseStatsSerializer(pagination.PaginationSerializer):
    class Meta:
        object_serializer_class = UserCourseStatsSerializer

class LessonUserStats(serializers.ModelSerializer):

    lessons_progress = serializers.SerializerMethodField('get_lessons_progress')
    forum_questions = serializers.SerializerMethodField('get_forum_questions')
    forum_answers = serializers.SerializerMethodField('get_forum_answers')

    class Meta:
        model = CourseStudent
        fields = ('lessons_progress',)

    @staticmethod
    def get_lessons_progress(obj):
        return obj.percent_progress_by_lesson()

    @staticmethod
    def get_forum_questions(obj):
        return obj.forum_questions_by_lesson()

    @staticmethod
    def get_forum_answers(obj):
        return obj.forum_answers_by_lesson()


class CourseStats(serializers.ModelSerializer):
    lessons_avg_progress = serializers.SerializerMethodField('get_lessons_avg_progress')
    # forum_answers = serializers.SerializerMethodField('get_forum_answers')

    class Meta:
        model = Course
        fields = ('slug', 'name', 'lessons_avg_progress',)

    @staticmethod
    def get_lessons_avg_progress(obj):
        if hasattr(obj, 'classes') and obj.classes:
            return obj.avg_lessons_users_progress(obj.classes)
        else:
            return obj.avg_lessons_users_progress()

    # @staticmethod
    # def get_forum_answers(obj):
    #     return obj.forum_answers_by_lesson()
