
(function (angular) {
    'use strict';
    /* Controllers */
    var app = angular.module('accounts.controllers', []);

    app.controller('ProfileCtrl', ['$scope', '$location', '$sce', '$window', 'Cities', 'States', 'Profile',
            function ($scope, $location, $sce, $window, Cities, States, Profile) {
                
                States.get(function(states){
                    $scope.list_states = states.states;
                    $scope.filters_selected_uf = states.states[0];
                });

                Profile.get(function(profile){
                    if (profile.city != null){
                        $scope.selected_city_code = profile.city.code;
                        $scope.selected_uf = profile.city.uf;
                        $scope.filters_selected_uf = $scope.selected_uf;

                        Cities.get({uf : $scope.selected_uf}, function(cities){
                            $scope.list_cities = cities.cities;
                        });
                    }
                });

                $scope.list_cities = [];

                $scope.filter_cities = function(){
                    Cities.get({uf : $scope.filters_selected_uf}, function(cities){
                        $scope.list_cities = cities.cities;
                        $scope.selected_city_code = null;
                    });
                }
        }]);
})(angular);
