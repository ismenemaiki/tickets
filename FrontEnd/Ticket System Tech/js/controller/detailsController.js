angular.module("ticketSystem").controller('detailsController', function (detail, updateAPI, localStorageService, $scope){
    var vm = this;
    details(detail);
    function details(selection){
        vm.ticket = selection.data.ticket;
    };
    var loadStatus = function(){
        updateAPI.getStatus().then(function(response){
            $scope.statuses = response.data;
        }).catch(function () {
            $scope.message = "Load status fail!";
        });
    };
    loadStatus(); 
    vm.save = function(ticket){
        updateAPI.updateTicket(ticket).then (function(){
            alert("Saved!")
            $state.go('attendant.workflow-attendant');
            
        }).catch(function(){
            message = "Update ticket fail";
        });
    };
    vm.reOpen = function(ticket){
        var model = {
            id: ticket.id,
            subject: ticket.subject,
            description: ticket.description,
            employee: ticket.employee,
            attendant: ticket.attendant,
            openness: new Date(),
            status:{
                id: 1,
                state: ''
            }
        }
        updateAPI.updateTicket(model).then(function(response){
            $scope.tickets = response.data;
            alert("ticket reopened successfully");
            $state.go('main.workflow-attendant');
        }).catch(function () {
            $scope.message = "Update status fail!";
        });
    }
    vm.s = function () {
        status = "New";
        loadTickets();
    };
});