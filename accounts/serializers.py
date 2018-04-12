from rest_framework import serializers
from django.contrib.auth import get_user_model
from .models import City, Occupation, Discipline, EducationDegree, EducationLevel, School, TimtecUserSchool


class TimtecUserSerializer(serializers.ModelSerializer):
    name = serializers.Field(source='get_full_name')
    picture = serializers.Field(source='get_picture_url')

    class Meta:
        model = get_user_model()
        fields = ('id', 'username', 'name', 'first_name', 'last_name', 'biography', 'picture',)


class TimtecUserAdminSerializer(TimtecUserSerializer):

    class Meta:
        model = get_user_model()
        fields = ('id', 'username', 'name', 'email', 'is_active', 'is_superuser', 'first_name', 'last_name',)

class CitySerializer(serializers.ModelSerializer):

    class Meta:
        model = City

class OccupationSerializer(serializers.ModelSerializer):

    class Meta:
        model = Occupation

class DisciplineSerializer(serializers.ModelSerializer):

    class Meta:
        model = Discipline

class EducationDegreeSerializer(serializers.ModelSerializer):

    class Meta:
        model = EducationDegree

class EducationLevelSerializer(serializers.ModelSerializer):

    class Meta:
        model = EducationLevel

class SchoolSerializer(serializers.ModelSerializer):

    class Meta:
        model = School

class SchoolCompleteSerializer(serializers.ModelSerializer):
    city = CitySerializer(required=True)
    school_type = serializers.SerializerMethodField('get_school_type')

    class Meta:
        model = School

    def get_school_type(self, obj):
        return obj.get_school_type_display()

class TimtecUserSchoolSerializer(serializers.ModelSerializer):
    school = SchoolSerializer(required=True)

    class Meta:
        model = TimtecUserSchool


class TimtecProfileSchoolSerializer(serializers.ModelSerializer):
    school = SchoolCompleteSerializer(required=True)
    education_levels = EducationLevelSerializer(many=True, required=True)

    class Meta:
        model = TimtecUserSchool

class TimtecProfileSerializer(serializers.ModelSerializer):
    city = CitySerializer(required=False)
    occupations = OccupationSerializer(many=True, required=False)
    disciplines = DisciplineSerializer(many=True, required=False)
    education_degrees = EducationDegreeSerializer(required=False, many=True)
    schools = TimtecProfileSchoolSerializer(source='timtecuserschool_set', many=True)

    class Meta:
        model = get_user_model()
        fields = ('city', 'occupations', 'disciplines', 'education_degrees', 'schools')