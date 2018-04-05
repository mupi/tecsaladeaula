
(function (angular) {
    'use strict';
    /* Controllers */
    var app = angular.module('accounts.controllers', []);

    app.controller('ProfileCtrl', ['$scope', '$location', '$sce', '$window', 'Cities', 'States', 'Occupations', 'Profile',
            function ($scope, $location, $sce, $window, Cities, States, Occupations, Profile) {
                
                States.query(function(states){
                    $scope.list_states = states;
                    $scope.filters_selected_uf = states[0];
                });

                Profile.get(function(profile){
                    if (profile.city != null){
                        $scope.selected_city_id = profile.city.id;
                        $scope.selected_uf = profile.city.uf;
                        $scope.filters_selected_uf = $scope.selected_uf;

                        Cities.query({uf : $scope.selected_uf}, function(cities){
                            $scope.list_cities = cities;
                        });
                    }
                    $scope.occupations = [];
                    $scope.occupations.selected = profile.occupations;
                    Occupations.query(function(occupations){
                        $scope.avaiable_occupations = occupations;
                    });
                });

                $scope.list_cities = [];

                $scope.filter_cities = function(){
                    Cities.query({uf : $scope.filters_selected_uf}, function(cities){
                        $scope.list_cities = cities;
                        $scope.selected_city_id = null;
                    });
                }
        }]);
})(angular);
