
(function (angular) {
    'use strict';
    /* Controllers */
    angular.module('reports.controllers', []).
        controller('ReportsCtrl', ['$scope', '$location', '$sce', '$window', 'CourseUserReport', 'LessonsUserProgress', 'Class', 'CourseStats',
            function ($scope, $location, $sce, $window, CourseUserReport, LessonsUserProgress, Class, CourseStats) {

                $scope.course_id = parseInt($window.course_id, 10);
                $scope.filters = {};
                $scope.filters.page = 1;
                $scope.filters.course = $scope.course_id;

            
                $scope.show_user_progress_details = function(user) {
                    if (user.lessons_stats === undefined) {
                        user.lessons_stats = LessonsUserProgress.get({courseId: $scope.course_id, user: user.user.id});
                    }
                };

                $scope.filter_stats = function(){
                    if ($scope.from_date == null)
                        $scope.filters.from_date = null;
                    else
                        $scope.filters.from_date = Date.parse($scope.from_date);

                    if ($scope.until_date == null)
                        $scope.filters.until_date = null;
                    else
                        $scope.filters.until_date = Date.parse($scope.until_date);

                    CourseStats.query($scope.filters, function (course_stats){
                        $scope.course_stats = course_stats;
                    });
                    CourseUserReport.get($scope.filters, function (users_reports){
                        $scope.users_reports = users_reports;
                    });
                }

                $scope.filter_stats();
        }]);
})(angular);
