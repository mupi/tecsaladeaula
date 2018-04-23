
(function (angular) {
    'use strict';
    /* Controllers */
    angular.module('reports.controllers', []).
        controller('ReportsCtrl', ['$scope', '$location', '$sce', '$window', 'CourseUserReport', 'LessonsUserProgress', 'Class', 'CourseStats',
            function ($scope, $location, $sce, $window, CourseUserReport, LessonsUserProgress, Class, CourseStats) {
                $scope.course_id = parseInt($window.course_id, 10);

                $scope.course_stats = CourseStats.get({courseId: $scope.course_id});
                $scope.users_reports = CourseUserReport.query({course: $scope.course_id});

                $scope.my_classes = [];
               
                $scope.show_user_progress_details = function(user) {
                    if (user.lessons_stats === undefined) {
                        user.lessons_stats = LessonsUserProgress.get({courseId: $scope.course_id, user: user.user_id});
                    }
                };

                $scope.filter_stats = function(){
                    $scope.course_stats = CourseStats.get({courseId: $scope.course_id}, function (course_stats){});
                    $scope.users_reports = CourseUserReport.query({course: $scope.course_id}, function (users_reports){});
                }
        }]);
})(angular);
