
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

                    $scope.school_infos = profile.schools;
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

                $scope.reload_schools = function(){

                }
        }]);

        app.controller('SchoolCtrl', ['$scope', '$http', '$location', '$sce', '$window', 'Cities', 'States', 'EducationLevels', 'SchoolTypes',
        function ($scope, $http, $location, $sce, $window, Cities, States, EducationLevels, SchoolTypes) {
            
            $scope.has_errors = false;
            $scope.form = {};
            
            $scope.education_levels = {};
            $scope.list_states = [];
            $scope.education_levels.selected = [];
            $scope.avaiable_education_levels = EducationLevels.query();

            SchoolTypes.query(function(schooltypes){
                $scope.schooltypes = schooltypes;
                $scope.form.school_type = schooltypes[0].value;
            });

            States.query(function(states){
                $scope.list_states = states;
                $scope.filters_selected_uf = states[0];
                $scope.filter_cities();
            });
            

            $scope.filter_cities = function(){
                Cities.query({uf : $scope.filters_selected_uf}, function(cities){
                    $scope.list_cities = cities;
                    $scope.form.city = cities[0].id;
                });
            }

            $scope.addSchoolForm = function() {
                $("#btn-add-school-table").prop('disabled', true);

                var education_levels = [];
                $scope.education_levels.selected.forEach(function(el){
                    education_levels.push(el.slug);
                });

                if (education_levels.length == 0){
                    $scope.has_errors = true;
                    $("#btn-add-school-table").prop('disabled', false);
                    return;
                }

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
                    $scope.form.name = "";
                    $scope.has_errors = false;
                    $scope.education_levels.selected = [];
                    $("#add-school-modal").modal('toggle');
                    $("#btn-add-school-table").prop('disabled', false);
                  })
                .error(function(data, status, headers, config){
                    $scope.has_errors = true;
                    $("#btn-add-school-table").prop('disabled', false);
                });
                
              }
    }]);
})(angular);
