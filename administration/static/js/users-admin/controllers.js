/*
1 - Campos multivalorados
*/
(function(angular){

    angular.module('users-admin.controllers', []).
        controller('UsersAdminController', ['$scope', '$window', '$modal', '$http', '$q', 'Cities', 'States', 'Occupations', 'Disciplines', 'EducationDegrees', 'UserAdmin',
        function($scope, $window, $modal, $http, $q, Cities, States, Occupations, Disciplines, EducationDegrees,  UserAdmin) {

            var success_save_msg = 'Alterações salvas com sucesso.';
            var error_save_msg = 'Não foi possível salvar as alterações.';

            var confirm_delete_user_msg = 'Tem certeza que deseja apagar este usuário? Esta operação não poderá ser desfeita!';
            var success_delete_user_msg = 'Usuário apagado com sucesso.';
            var error_delete_user_msg = 'Erro ao apagar usuário.';

            /*ini 1*/
            $scope.filters = {};
            $scope.occupations = [];
            $scope.disciplines = [];
            $scope.education_degrees = [];

            $scope.avaiable_occupations = Occupations.query();
            $scope.avaiable_disciplines = Disciplines.query();
            $scope.avaiable_education_degrees = EducationDegrees.query();

            States.query(function(states){
                $scope.list_states = [" "];
                $scope.list_states.push.apply($scope.list_states, states);
                $scope.filters.selected_uf = " ";
            });


            $scope.filter_cities = function(){
                Cities.query({uf : $scope.filters.selected_uf}, function(cities){
                    $scope.list_cities = [{name: " ", value: " "}];
                    $scope.list_cities.push.apply($scope.list_cities, cities);
                    $scope.selected_city_id = " ";
                });
            }

            /*fin 1*/

            UserAdmin.get({page: 1}, function(users_page){
                $scope.total_users_found = users_page.count;
                $scope.users_page = users_page;
            });

            $scope.filter_users = function() {
                UserAdmin.get($scope.filters, function(users_page) {
                    $scope.filtered = true;
                    $scope.total_users_found = users_page.count;
                    $scope.users_page = users_page;
                });
            };

            $scope.page_changed = function() {
                UserAdmin.get({page: $scope.current_page}, function(users_page){
                    $scope.users_page = users_page;
                });
            };

            $scope.update_user = function(user) {
                user.$update({user_id: user.id}, function() {
                    $scope.alert.success(success_save_msg);
                }, function() {
                    $scope.alert.error(error_save_msg);
                });
            };

            $scope.delete_user = function(user, index) {
                if (confirm(confirm_delete_user_msg)) {
                    user.$remove({user_id: user.id}, function() {
                        $scope.users_page.splice(index, 1);
                        $scope.alert.success(success_delete_user_msg);
                    }, function() {
                        $scope.alert.error(error_delete_user_msg);
                    });
                }
            };
        }
    ]);

})(angular);
