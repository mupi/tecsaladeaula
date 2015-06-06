(function(angular){
    'use strict';

    angular.module('course', [
        'new-course',
    ]).config(function($interpolateProvider){
        $interpolateProvider.startSymbol('[[');
        $interpolateProvider.endSymbol(']]');
    });
})(window.angular);
