
(function (angular) {
    'use strict';

    var module = angular.module('users-admin.services', ['ngResource']);

    module.factory('UserAdmin', function($resource){
        return $resource('/api/user_admin/:user_id', {}, {
            update: {method: 'PUT'}
        });
        }).factory('Cities', function($resource){
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
      });
})(angular);
