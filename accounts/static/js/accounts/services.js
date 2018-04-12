
(function (angular) {
    'use strict';
    /* Services */
    angular.module('accounts.services', ['ngResource']).
        factory('Cities', function($resource){
            return $resource('/api/cities', {}, {
            });
        }).factory('States', function($resource){
            return $resource('/api/states', {}, {
            });
        }).factory('Occupations', function($resource){
            return $resource('/api/occupations', {}, {
            });
        }).factory('EducationDegrees', function($resource){
            return $resource('/api/educationdegrees', {}, {
            });
        }).factory('Disciplines', function($resource){
            return $resource('/api/disciplines', {}, {
            });
        }).factory('EducationLevels', function($resource){
            return $resource('/api/educationlevels', {}, {
            });
        }).factory('SchoolTypes', function($resource){
            return $resource('/api/schooltypes', {}, {
            });
        }).factory('UserSchools', function($resource){
            return $resource('/api/userschools', {}, {
            });
        }).factory('Schools', function($resource){
            return $resource('/api/schools', {}, {
            });
        }).factory('Profile', function($resource){
            return $resource('/api/profile', {}, {
            });
        });
})(angular);
