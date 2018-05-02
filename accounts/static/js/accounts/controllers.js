
(function (angular) {
    'use strict';
    /* Controllers */
    var app = angular.module('accounts.controllers', []);

    app.controller('ProfileCtrl', ['$scope', '$rootScope', '$location', '$sce', '$window', 'Cities', 'States', 'Occupations', 'Disciplines', 'EducationDegrees', 'UserSchools', 'Profile',
            function ($scope, $rootScope, $location, $sce, $window, Cities, States, Occupations, Disciplines, EducationDegrees, UserSchools, Profile) {
                
                $scope.form = {};
                $scope.form.occupations = {};
                $scope.form.disciplines = {};
                $scope.form.disciplines.selected = [];
                $scope.form.education_degrees = {};

                $scope.avaiable_occupations = Occupations.query();
                $scope.avaiable_disciplines = Disciplines.query();
                $scope.avaiable_education_degrees = EducationDegrees.query();

                States.query(function(ufs){
                    $scope.list_ufs = ufs;
                });

                var load_profile = function(){
                    Profile.get(function(profile){
                        if (profile.city != null){
                            $scope.form.uf = profile.city.uf;
                            $scope.form.city = profile.city;

                            Cities.query({uf : $scope.form.uf}, function(cities){
                                $scope.list_cities = cities;
                            });
                        }
                        $scope.form.occupations.selected = profile.occupations;
                        $scope.form.disciplines.selected = profile.disciplines;
                        $scope.form.education_degrees.selected = profile.education_degrees;

                        $scope.school_infos = profile.schools;
                    })
                };
                var reload_schools = function(){
                    Profile.get(function(profile){
                        $scope.school_infos = profile.schools;
                    })
                }
                load_profile();

                $scope.filter_cities = function(){
                    Cities.query({uf : $scope.form.uf}, function(cities){
                        $scope.list_cities = cities;
                        $scope.form.city_id = cities[0].id;
                    });
                }

                $scope.add_discipline = function(){
                    if ($scope.form.other_discipline.trim() == '')
                        return;
                    else 
                        $scope.form.disciplines.selected.push({name: $scope.form.other_discipline});
                    
                    
                    $scope.form.other_discipline = null;
                }

                $scope.school_form_modal = function(id){
                    $rootScope.$broadcast('school_form_modal', id);
                }

                $scope.remove_school = function(id){
                    if(confirm("Está seguro de remover esta escola/instituição?")){
                        UserSchools.get({id:id}, function(school){
                            school.$delete()
                            .then(function(res) {
                                reload_schools();
                            });
                        });
                    }
                }

                $scope.$on('reload_schools', reload_schools);
        }]);

        app.controller('SchoolCtrl', ['$scope', '$rootScope', '$http', '$location', '$sce', '$window', 'Cities', 'States', 'EducationLevels', 'UserSchools', 'SchoolTypes',
        function ($scope, $rootScope, $http, $location, $sce, $window, Cities, States, EducationLevels, UserSchools, SchoolTypes) {
            
            $scope.form = {};
            $scope.form.has_errors = false;
            
            $scope.form.education_levels = {};
            $scope.form.education_levels.selected = [];

            $scope.list_ufs = [];
            $scope.avaiable_education_levels = EducationLevels.query();

            SchoolTypes.query(function(list_schooltypes){
                $scope.list_schooltypes = list_schooltypes;
                $scope.form.school_type = list_schooltypes[0].value;
            });

            States.query(function(ufs){
                $scope.list_ufs = ufs;
                $scope.form.uf = ufs[0];
                $scope.filter_cities();
            });
            

            $scope.filter_cities = function(){
                Cities.query({uf : $scope.form.uf}, function(cities){
                    $scope.list_cities = cities;
                    $scope.form.city_id = cities[0].id;
                });
            }

            $scope.addSchoolForm = function() {
                $("#btn-add-school-table").prop('disabled', true);

                var education_levels = [];
                $scope.form.education_levels.selected.forEach(function(el){
                    education_levels.push(el.slug);
                });

                if (education_levels.length == 0){
                    $scope.form.has_errors = true;
                    $("#btn-add-school-table").prop('disabled', false);
                    return;
                }
                var user_school = new UserSchools();

                user_school.school = {};
                if ($scope.form.id > 0)
                    user_school.id = $scope.form.id;
                user_school.school.name = $scope.form.name;
                user_school.school.school_type = $scope.form.school_type;
                user_school.school.city = $scope.form.city_id;
                user_school.education_levels = education_levels;

                if ($scope.form.id > 0){
                    user_school.$update()
                    .then(function(res) {
                        $rootScope.$broadcast('reload_schools');
                        $("#add-school-modal").modal('toggle');
                        $
                    })
                    .catch(function(req){
                        $scope.form.has_errors = true;
                    })
                } else {
                    user_school.$save()
                    .then(function(res) {
                        $rootScope.$broadcast('reload_schools');
                        $("#add-school-modal").modal('toggle');
                        $
                    })
                    .catch(function(req){
                        $scope.form.has_errors = true;
                    })
                }
                $("#btn-add-school-table").prop('disabled', false);
            }

            var school_form_modal = function(event, id){
                $("#add-school-modal").modal();
                $scope.form.id = id;
                if (id > 0){
                    UserSchools.get({id: id}, function(user_school){
                        $scope.form.uf = user_school.school.city.uf;
                        Cities.query({uf : $scope.form.uf}, function(cities){
                            $scope.list_cities = cities;
                            $scope.form.city_id = user_school.school.city.id;
                        });
                        
                        $scope.form.name = user_school.school.name;
                        $scope.form.school_type = user_school.school.school_type;
                        $scope.form.education_levels.selected = user_school.education_levels;
                    });
                } else {
                    $scope.form.name = "";
                    $scope.form.has_errors = false;
                    $scope.form.school_type = $scope.list_schooltypes[0].value;
                    $scope.form.education_levels.selected = [];
                    $scope.form.uf = $scope.list_ufs[0];
                    Cities.query({uf : $scope.form.uf}, function(cities){
                        $scope.list_cities = cities;
                        $scope.form.city_id = cities[0].id;
                    });
                }
            }

            $scope.$on('school_form_modal', school_form_modal);
    }]);
})(angular);
