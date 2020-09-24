
(function (angular) {
    'use strict';
    /* Controllers */
    angular.module('reports.controllers', []).
        controller('ReportsCtrl', ['$scope', '$location', '$sce', '$window', 'CourseUserReport', 'LessonsUserProgress', 'Class', 'CourseStats',
            function ($scope, $location, $sce, $window, CourseUserReport, LessonsUserProgress, Class, CourseStats) {

                $scope.course_id = parseInt($window.course_id, 10);
                $scope.filters = {};
                $scope.filters.page = 1;
                $scope.filters.percentage_completion = 0;
                $scope.filters.course = $scope.course_id;


                $scope.show_user_progress_details = function(user) {
                    if (user.lessons_stats === undefined) {
                        user.lessons_stats = LessonsUserProgress.get({courseId: $scope.course_id, user: user.user.id});
                    }
                };

                $scope.check_day = function(){
                    if ($scope.filters.days_inactive != null && $scope.filters.days_inactive <= 0){
                        $scope.filters.days_inactive = "";
                    }
                }

                $scope.export_csv = function() {

                    var query_string = '?';
                    if($scope.filters.course)
                        query_string += 'course_id='+$scope.filters.course + "&";
                    if ($scope.filters.keyword)
                        query_string += "keyword=" + $scope.filters.keyword + "&"
                    if ($scope.filters.percentage_completion)
                        query_string += "percentage_completion=" + $scope.filters.percentage_completion + "&"
                    if ($scope.from_date)
                        query_string += "from_date=" + Date.parse($scope.from_date) + "&"
                    if ($scope.until_date)
                        query_string += "until_date=" + Date.parse($scope.until_date) + "&"
                    if ($scope.filters.days_inactive)
                        query_string += "days_inactive=" + $scope.filters.days_inactive + "&"

                    $window.open('/admin/course/users/export/simple/' + query_string);
                }


                $scope.export_csv_simple = function() {

                    var query_string = '?';
                    if($scope.filters.course)
                        query_string += 'course_id='+$scope.filters.course + "&";
                    if ($scope.from_date)
                        query_string += "from_date=" + Date.parse($scope.from_date) + "&"
                    if ($scope.until_date)
                        query_string += "until_date=" + Date.parse($scope.until_date) + "&"

                    $window.open('/admin/course/users/export/simple/' + query_string);
                }

                $scope.export_progress_csv = function(user) {

                    var query_string = '?';
                    if($scope.filters.course)
                        query_string += 'course_id='+$scope.filters.course + "&";
                    query_string += "user_id=" + user.user.id

                    $window.open('/admin/course/users_progess/export/' + query_string);
                }

                $scope.filter_stats = function(){
                    if ($scope.from_date == null)
                        $scope.filters.from_date = null;
                    else
                        $scope.filters.from_date = Date.parse($scope.from_date);

                    if ($scope.until_date == null)
                        $scope.filters.until_date = null;
                    else
                        $scope.filters.until_date = Date.parse($scope.until_date);

                    CourseStats.get({courseId : $scope.course_id}, function (course_stats){
                        $scope.course_stats = course_stats;
                    });
                    CourseUserReport.get($scope.filters, function (users_reports){
                        $scope.users_reports = users_reports;
                    });
                }

                $scope.filter_stats();
        }]);
})(angular);
