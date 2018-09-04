angular.module('ticketSystem')
    .config(['$urlRouterProvider', '$stateProvider', function ($urlRouterProvider, $stateProvider) {
        $urlRouterProvider.otherwise("/login");
        $stateProvider
            .state('login', {
                url: '/login',
                abstract: true,
                template: "<ui-view/>",
            })
            .state('login.form', { 
                url: '',
                controller: 'loginController',
                templateUrl: "view/login.layout.html",
                controllerAs: 'vm'
            })
            .state('employee', { 
                url: '/main-employee',
                templateUrl: 'view/menu.layout.employee.html',
                controller: 'ticketSystemController',
                controllerAs: 'vm'
            })
            .state('employee.workflow', { 
                url: '/workflow-employee',
                templateUrl: 'view/workflow-employee.html',
                controller: 'ticketSystemController',
                controllerAs: 'vm'
            })
            .state('employee.form', {
                url: '/form',
                templateUrl: 'view/form.html',
                controller: 'ticketSystemController',
                controllerAs: 'vm'
            })
            .state('employee.details', {
                url: '/details',
                templateUrl: 'view/details-employee.html',
                controller: 'detailsController',
                controllerAs: 'vm',
                params: {
                    id: 0
                },
                resolve: {
                    detail: ['updateAPI', '$stateParams', function (updateAPI, $stateParams) {
                        return updateAPI.detailsTicket($stateParams.id);
                    }]
                }
            })
            .state('attendant', { 
                abstract: false,
                url: '/main-attendant',
                templateUrl: 'view/menu.layout.attendant.html',
                controller: 'ticketSystemController',
                controllerAs: 'vm'
            })
            .state('attendant.workflow-attendant', {
                url: '/workflow-attendant',
                templateUrl: 'view/workflow-attendant.html',
                controller: 'ticketSystemController',
                controllerAs: 'vm'
            })
            .state('attendant.details-attendant', {
                url: '/details-attendant',
                templateUrl: 'view/details-attendant.html',
                controller: 'detailsController',
                controllerAs: 'vm',
                params: {
                    id: 0
                },
                resolve: {
                    detail: ['updateAPI', '$stateParams', function (updateAPI, $stateParams) {
                        return updateAPI.detailsTicket($stateParams.id);
                    }]
                }
            })
    }]);