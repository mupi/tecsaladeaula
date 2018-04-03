
(function (angular) {
    'use strict';
    /* Controllers */
    var app = angular.module('accounts.controllers', []);

    app.controller('ProfileCtrl', ['$scope', '$location', '$sce', '$window', 'Cities', 'States',
            function ($scope, $location, $sce, $window, Cities, States) {
                
                States.get(function(states){
                    $scope.list_states = states.states;
                });
                

                $scope.list_cities = [];

                $scope.filter_cities = function(){
                    Cities.get({uf : $scope.filters.selected_uf}, function(cities){
                        $scope.list_cities = cities.cities;
                    });
                }
        }]);
})(angular);
