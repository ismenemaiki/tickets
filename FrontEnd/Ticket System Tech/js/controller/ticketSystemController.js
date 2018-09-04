angular.module('ticketSystem').controller("ticketSystemController", function ($scope, ticketsAPI, localStorageService, $state) {
    var vm = this;
    this.user = localStorageService.get('user');
    $scope.teste = "Testando controller";

    vm.goDetails = function (ticketId) {
        $state.go('employee.details', {
            id: ticketId
        });
    }
    vm.goDetailsAttendant = function (ticketId) {
        $state.go('attendant.details-attendant', {
            id: ticketId
        });
    }
    vm.goBack = function (ticket) {
        $state.go('main.workflow', {
            ticket: $scope.tickets
        });
    }
    var loadTickets = function () {
        ticketsAPI.getTickets().then(function (response) {
            $scope.tickets = response.data;
            console.log(tickets);
        }).catch(function () {
            $scope.message = "Load tickets fail!";
        });
    };
    loadTickets();

    vm.addTicket = function (subject, description) {
        var newTicket = {
            subject: subject,
            description: description,
            openness: new Date(),
            status: {
                Id: 1, 
                State: 'New'
            },
            //attendant: {type = 2 ? attendant : employee},
            attendant: {
                id: 2,
                Name: 'Rafael Sousa'
            },
            employee: {
                Id: 1,
                Name: 'Felipe Rugai'
            }
        };
        ticketsAPI.postTicket(newTicket).then(function (response) {
            $scope.tickets = response.data;
            alert("ticket successfully add!");
            $state.go('employee.workflow');
        }).catch(function () {
            $scope.message = "Add tickets fail!";
        });
    };
    vm.delete = function (ticketId) {
        var deleteTicket = ticketId;
        ticketsAPI.deleteTicket(deleteTicket).then(function (response) {
            $scope.tickets = response.data;
            alert("ticket " + ticketId + " deleted!");
            loadTickets();
        }).catch(function () {
            $scope.message = "Delete tickets fail!";
        });
    }
    vm.statusInProgress = function () {
        statusId = 2;
        ticketsAPI.getStatusInProgress(statusId).then(function(response){
            $scope.tickets = response.data;
        }).catch(function(){
            $scope.message = "fail!";
        });
    };
    vm.statusNew = function () {
        statusId = 1;
        ticketsAPI.getStatusNew(statusId).then(function(response){
            $scope.tickets = response.data;
        }).catch(function(){
            $scope.message = "fail!";
        });
    };
    vm.statusFinished = function () {
        statusId = 3;
        ticketsAPI.getStatusFinished(statusId).then(function(response){
            $scope.tickets = response.data;
        }).catch(function(){
            $scope.message = "fail!";
        });
    };
    vm.statusAll = function () {
        loadTickets()
    };
});