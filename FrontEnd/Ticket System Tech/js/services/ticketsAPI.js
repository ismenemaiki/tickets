angular.module('ticketSystem').factory('ticketsAPI', function ($http, valueUrl){
    var _getTickets = function (){
        return $http.get(valueUrl.baseUrl +'/tickets/listall');
    };
    var _postTicket = function(ticket){
        return $http.post(valueUrl.baseUrl + '/tickets/newticket', ticket);
    };
    var _deleteTicket = function(id){
        return $http.post(valueUrl.baseUrl +'/tickets/delete?id=' + id)
    };
    var _getStatusInProgress = function(statusId){
        return $http.get(valueUrl.baseUrl + '/tickets/getStatus?statusId=' + statusId)
    };
    var _getStatusNew = function(statusId){
        return $http.get(valueUrl.baseUrl + '/tickets/getStatus?statusId=' + statusId)
    };
    var _getStatusFinished = function(statusId){
        return $http.get(valueUrl.baseUrl + '/tickets/getStatus?statusId=' + statusId)
    };
    return {
        getTickets: _getTickets,
        postTicket: _postTicket,
        deleteTicket: _deleteTicket,
        getStatusInProgress: _getStatusInProgress,
        getStatusNew: _getStatusNew,
        getStatusFinished: _getStatusFinished
    };
});