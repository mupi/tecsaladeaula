
(function (angular) {
    'use strict';
    /* Controllers */
    var app = angular.module('accounts.controllers', []);

    app.controller('ProfileCtrl', ['$scope', '$rootScope', '$location', '$sce', '$window', 'Cities', 'States', 'Occupations', 'Disciplines', 'EducationDegrees', 'UserSchools', 'Profile',
            function ($scope, $rootScope, $location, $sce, $window, Cities, States, Occupations, Disciplines, EducationDegrees, UserSchools, Profile) {
                
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

                var load_profile = function(){
                    Profile.get(function(profile){
                        if (profile.city != null){
                            $scope.selected_city_id = profile.city.id;
                            $scope.filters_selected_uf = profile.city.uf;

                            Cities.query({uf : $scope.filters_selected_uf}, function(cities){
                                $scope.list_cities = cities;
                            });
                        }
                        $scope.occupations.selected = profile.occupations;
                        $scope.disciplines.selected = profile.disciplines;
                        $scope.education_degrees.selected = profile.education_degrees;

                        $scope.school_infos = profile.schools;
                    })
                };
                load_profile();

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

                $scope.school_form_modal = function(id){
                    $rootScope.$broadcast('school_form_modal', id);
                }

                $scope.remove_school = function(id){
                    if(confirm("Está seguro de remover esta escola/instituição?")){
                        UserSchools.get({id:id}, function(school){
                            school.$delete()
                            .then(function(res) {
                                load_profile();
                            });
                        });
                    }
                }

                $scope.$on('reload_profile', load_profile);
        }]);

        app.controller('SchoolCtrl', ['$scope', '$rootScope', '$http', '$location', '$sce', '$window', 'Cities', 'States', 'EducationLevels', 'UserSchools', 'SchoolTypes',
        function ($scope, $rootScope, $http, $location, $sce, $window, Cities, States, EducationLevels, UserSchools, SchoolTypes) {
            
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
                var user_school = new UserSchools();

                user_school.school = {};
                if ($scope.form.id > 0)
                    user_school.id = $scope.form.id;
                user_school.school.name = $scope.form.name;
                user_school.school.school_type = $scope.form.school_type;
                user_school.school.city = $scope.form.city;
                user_school.education_levels = education_levels;

                if ($scope.form.id > 0){
                    console.log(user_school);
                    user_school.$update()
                    .then(function(res) {
                        $rootScope.$broadcast('reload_profile');
                        $("#add-school-modal").modal('toggle');
                        $
                    })
                    .catch(function(req){
                        $scope.has_errors = true;
                    })
                } else {
                    user_school.$save()
                    .then(function(res) {
                        $rootScope.$broadcast('reload_profile');
                        $("#add-school-modal").modal('toggle');
                        $
                    })
                    .catch(function(req){
                        $scope.has_errors = true;
                    })
                }
                $("#btn-add-school-table").prop('disabled', false);
            }

            var school_form_modal = function(event, id){
                $("#add-school-modal").modal();
                $scope.form.id = id;
                if (id > 0){
                    UserSchools.get({id: id}, function(user_school){
                        $scope.filters_selected_uf = user_school.school.city.uf;
                        Cities.query({uf : $scope.filters_selected_uf}, function(cities){
                            $scope.list_cities = cities;
                            $scope.form.city = user_school.school.city.id;
                        });
                        
                        $scope.form.name = user_school.school.name;
                        $scope.form.school_type = user_school.school.school_type;
                        $scope.education_levels.selected = user_school.education_levels;
                        console.log(user_school);
                    });
                } else {
                    $scope.form.name = "";
                    $scope.has_errors = false;
                    $scope.form.school_type = $scope.schooltypes[0].value;
                    $scope.education_levels.selected = [];
                    $scope.filters_selected_uf = $scope.list_states[0];
                    $scope.filter_cities = function(){
                        Cities.query({uf : $scope.filters_selected_uf}, function(cities){
                            $scope.list_cities = cities;
                            $scope.form.city = cities[0].id;
                        });
                    }
                }
            }

            $scope.$on('school_form_modal', school_form_modal);
    }]);
})(angular);
