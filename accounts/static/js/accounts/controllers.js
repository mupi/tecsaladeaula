
(function (angular) {
    'use strict';
    /* Controllers */
    var app = angular.module('accounts.controllers', []);

    app.controller('ProfileCtrl', ['$scope', '$location', '$sce', '$window', 'Cities', 'States', 'Occupations', 'Disciplines', 'EducationDegrees', 'Profile',
            function ($scope, $location, $sce, $window, Cities, States, Occupations, Disciplines, EducationDegrees, Profile) {
                
                $scope.occupations = [];
                $scope.disciplines = [];
                $scope.education_degrees = [];

                $scope.avaiable_occupations = Occupations.query();
                $scope.avaiable_disciplines = Disciplines.query();
                $scope.avaiable_education_degrees = EducationDegrees.query();

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
                    $scope.occupations.selected = profile.occupations;
                    $scope.disciplines.selected = profile.disciplines;
                    $scope.education_degrees.selected = profile.education_degrees;
                });

                $scope.filter_cities = function(){
                    Cities.query({uf : $scope.filters_selected_uf}, function(cities){
                        $scope.list_cities = cities;
                        $scope.selected_city_id = null;
                    });
                }

                $scope.add_discipline = function(){
                    if ($scope.other_discipline == '')
                        return;
                    if ($scope.disciplines.selected == null){
                        $scope.disciplines.selected = [{name: $scope.other_discipline}];
                    } else {
                        $scope.disciplines.selected.push({name: $scope.other_discipline});
                    }
                    
                    $scope.other_discipline = null;
                }
        }]);
})(angular);
