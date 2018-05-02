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
            $scope.filters.occupations = [];
            $scope.filters.disciplines = [];
            $scope.filters.education_degrees = [];
            $scope.occupations = {};
            $scope.disciplines = {};
            $scope.education_degrees = {};
            $scope.occupations.selected = [];
            $scope.disciplines.selected = [];
            $scope.education_degrees.selected = [];

            $scope.avaiable_occupations = Occupations.query();
            Disciplines.query(function(disciplines){
                $scope.avaiable_disciplines = disciplines;
                $scope.avaiable_disciplines.push({'name': 'Outras', 'id': -1});
            });
            
            $scope.avaiable_education_degrees = EducationDegrees.query();

            States.query(function(ufs){
                $scope.list_ufs = ufs;
                $scope.filters.uf = "";
            });


            $scope.filter_cities = function(){
                Cities.query({uf : $scope.filters.uf}, function(cities){
                    $scope.list_cities = cities;
                    $scope.filters.city = "";
                });
            }

            /*fin 1*/

            UserAdmin.get({page: 1}, function(users_page){
                $scope.total_users_found = users_page.count;
                $scope.users_page = users_page;
            });

            $scope.filter_users = function() {
                $scope.filters.occupations = [];
                $scope.occupations.selected.forEach(function(el){
                    $scope.filters.occupations.push(el.id);
                });

                $scope.filters.education_degrees = [];
                $scope.education_degrees.selected.forEach(function(el){
                    $scope.filters.education_degrees.push(el.id);
                });

                $scope.filters.disciplines = [];
                $scope.disciplines.selected.forEach(function(el){
                    $scope.filters.disciplines.push(el.id);
                });
                
                UserAdmin.get($scope.filters, function(users_page) {
                    $scope.filtered = true;
                    $scope.total_users_found = users_page.count;
                    $scope.users_page = users_page;
                });
            };

            $scope.reset_filter = function() {
                $scope.filters.page = 1;
                $scope.filter_users();
            };



            $scope.export_csv = function() {
                console.log('export csv');
                var query_string = '?';
                if ($scope.filters.keyword)
                    query_string += "keyword=" + $scope.filters.keyword + "&"
                if ($scope.filters.uf)
                    query_string += "uf=" +     $scope.filters.uf + "&"
                if ($scope.filters.city)
                    query_string += "city=" + $scope.filters.city + "&"
                if ($scope.filters.blocked)
                    query_string += "blocked=" + $scope.filters.blocked + "&"
                if ($scope.filters.admin)
                    query_string += "admin=" + $scope.filters.admin + "&"
                $scope.filters.disciplines.forEach(function(discipline){
                    query_string += "disciplines=" + discipline + "&"
                });
                $scope.filters.occupations.forEach(function(occupation){
                    query_string += "occupations=" + occupation + "&"
                });
                $scope.filters.education_degrees.forEach(function(ed){
                    query_string += "education_degrees=" + ed + "&"
                });

                $window.open('/admin/users/export' + query_string);
            };

            $scope.update_user = function(user) {
                UserAdmin.get({user_id: user.id}, function(u){
                    u.is_active = user.is_active;
                    u.is_superuser = user.is_superuser;
                    u.$update({user_id: user.id})
                    .then(function(res) {
                        $scope.alert.success(success_save_msg);
                    })
                    .catch(function(req){
                        $scope.alert.error(error_save_msg);
                    })
                });
            };

            $scope.delete_user = function(user, index) {
                if (confirm(confirm_delete_user_msg)) {
                    UserAdmin.remove({user_id: user.id}, function() {
                        $scope.filter_users();
                        $scope.alert.success(success_delete_user_msg);
                    }, function() {
                        $scope.alert.error(error_delete_user_msg);
                    });
                }
            };
        }
    ]);

})(angular);
