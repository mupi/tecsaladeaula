from core.models import Course, CourseAuthor, Lesson, Unit
from core.serializers import VideoSerializer
from activities.models import Activity
from course_material.models import CourseMaterial
from course_material.serializers import FilesSerializer
from rest_framework import serializers


class JSONSerializerField(serializers.WritableField):
    pass

class CourseAuthorsExportSerializer(serializers.ModelSerializer):
    name = serializers.Field(source='get_name')
    biography = serializers.Field(source='get_biography')
    picture = serializers.Field(source='get_picture_url')

    class Meta:
        model = CourseAuthor
        exclude = ('id', 'user', 'course',)


class CourseAuthorsImportSerializer(serializers.ModelSerializer):

    class Meta:
        model = CourseAuthor
        exclude = ('id', 'user', 'course',)


class CourseMaterialImportExportSerializer(serializers.ModelSerializer):
    files = FilesSerializer(many=True, required=False)

    class Meta:
        model = CourseMaterial
        fields = ('text', 'files',)


class ActivityImportExportSerializer(serializers.ModelSerializer):
    data = JSONSerializerField('data')
    expected = JSONSerializerField('expected', required=False)

    class Meta:
        model = Activity
        exclude = ('id', 'unit',)


class UnitImportExportSerializer(serializers.ModelSerializer):
    video = VideoSerializer()
    activities = ActivityImportExportSerializer(many=True, allow_add_remove=True)

    class Meta:
        model = Unit
        exclude = ('id', 'lesson',)


class LessonImportExportSerializer(serializers.ModelSerializer):
    units = UnitImportExportSerializer(many=True, allow_add_remove=True)

    class Meta:
        model = Lesson
        exclude = ('id', 'course',)


class CourseExportSerializer(serializers.ModelSerializer):
    lessons = LessonImportExportSerializer(many=True, allow_add_remove=True)
    course_authors = CourseAuthorsExportSerializer(many=True, allow_add_remove=True,)
    intro_video = VideoSerializer()
    course_material = CourseMaterialImportExportSerializer()

    class Meta:
        model = Course
        fields = ('slug', 'name', 'intro_video', 'application', 'requirement', 'abstract', 'structure',
                  'workload', 'status', 'thumbnail', 'home_thumbnail', 'home_position',
                  'start_date', 'home_published', 'course_authors', 'lessons', 'course_material', 'riw_style')


class CourseImportSerializer(serializers.ModelSerializer):
    lessons = LessonImportExportSerializer(many=True, allow_add_remove=True)
    course_authors = CourseAuthorsImportSerializer(many=True, allow_add_remove=True)
    intro_video = VideoSerializer()
    # course_material = CourseMaterialImportExportSerializer()

    class Meta:
        model = Course
        fields = ('slug', 'name', 'intro_video', 'application', 'requirement', 'abstract', 'structure',
                  'workload', 'status', 'thumbnail', 'home_thumbnail', 'home_position',
                  'start_date', 'home_published', 'course_authors', 'lessons', 'riw_style')
