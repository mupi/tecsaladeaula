
(function (angular) {
    'use strict';
    /* Controllers */
    var app = angular.module('accounts.controllers', []);

    app.controller('ProfileCtrl', ['$scope', '$location', '$sce', '$window', 'Cities', 'States', 'Occupations', 'Disciplines', 'EducationDegrees', 'Schools', 'Profile',
            function ($scope, $location, $sce, $window, Cities, States, Occupations, Disciplines, EducationDegrees, Schools, Profile) {
                
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

                $scope.remove_school = function(id){
                    if(confirm("Está seguro de remover esta escola/instituição?")){
                    }
                }
                
                $scope.reload_schools = function(){

                }
        }]);

        app.controller('SchoolCtrl', ['$scope', '$http', '$location', '$sce', '$window', 'Cities', 'States', 'EducationLevels', 'UserSchools', 'SchoolTypes',
        function ($scope, $http, $location, $sce, $window, Cities, States, EducationLevels, UserSchools, SchoolTypes) {
            
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

                var school_profile = new UserSchools();
                school_profile.school = {};
                school_profile.school.name = $scope.form.name;
                school_profile.school.school_type = $scope.form.school_type;
                school_profile.school.city = $scope.form.city;
                school_profile.education_levels = education_levels;


                school_profile.$save()
                .then(function(res) {
                    $scope.form.name = "";
                    $scope.has_errors = false;
                    $scope.education_levels.selected = [];
                    $("#add-school-modal").modal('toggle');
                  })
                .catch(function(req){
                    $scope.has_errors = true;
                })
                .finally(function(){
                    $("#btn-add-school-table").prop('disabled', false);
                });
                
              }
    }]);
})(angular);
