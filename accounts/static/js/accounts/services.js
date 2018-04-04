
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
        }).factory('Profile', function($resource){
            return $resource('/api/profile', {}, {
            });
        });
})(angular);
