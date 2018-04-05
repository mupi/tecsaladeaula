
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
        }).factory('Profile', function($resource){
            return $resource('/api/profile', {}, {
            });
        });
})(angular);
