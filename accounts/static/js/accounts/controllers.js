
(function (angular) {
    'use strict';
    /* Controllers */
    var app = angular.module('accounts.controllers', []);

    app.controller('ProfileCtrl', ['$scope', '$location', '$sce', '$window', 'Cities', 'States', 'Occupations', 'Disciplines', 'EducationDegrees', 'Profile',
            function ($scope, $location, $sce, $window, Cities, States, Occupations, Disciplines, EducationDegrees, Profile) {
                
                $scope.occupations = {};
                $scope.disciplines = {};
                $scope.education_degrees = {};

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

        app.controller('SchoolCtrl', ['$scope', '$http', '$location', '$sce', '$window', 'Cities', 'States', 'EducationLevels', 'SchoolTypes',
        function ($scope, $http, $location, $sce, $window, Cities, States, EducationLevels, SchoolTypes) {
            
            $scope.form = {};
            $scope.education_levels = {};
            $scope.education_levels.selected = [];
            $scope.avaiable_education_levels = EducationLevels.query();
            $scope.schooltypes = SchoolTypes.query();

            States.query(function(states){
                $scope.list_states = states;
                $scope.filters_selected_uf = states[0];
            });
            

            $scope.filter_cities = function(){
                Cities.query({uf : $scope.filters_selected_uf}, function(cities){
                    $scope.list_cities = cities;
                    $scope.form.city = cities[0].id;
                });
            }

            $scope.addSchoolForm = function() {
                var education_levels = [];
                $scope.education_levels.selected.forEach(function(el){
                    education_levels.push(el.slug);
                });
                var parameter = JSON.stringify(
                {  
                    "school": {   
                        name:           $scope.form.name,
                        school_type:    $scope.form.school_type,
                        city:           $scope.form.city
                    },
                    "education_levels": education_levels
                });

                $http({
                    method  : 'POST',
                    url     : '/api/schools',
                    data    : parameter,
                    headers : { 'Content-Type': 'application/json'
                    }
                })
                .success(function(data, status, headers, config) {
                    $("#add-school-modal").modal('toggle');
                  })
                .error(function(data, status, headers, config){
                    //do anything when errors...
                });
              }
    }]);
})(angular);
