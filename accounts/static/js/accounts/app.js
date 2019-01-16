(function (angular) {
    'use strict';

    // Declare app level module which depends on filters, and services
    angular.module('accounts', [
        'accounts.controllers',
        'accounts.services',
        'django',
        'ui.bootstrap',        
        'ui.select',
        'ngSanitize',
        'ui.utils.masks'
    ]);
})(angular);
