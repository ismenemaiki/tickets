angular.module('ticketSystem').factory('updateAPI', function ($http, valueUrl){
    var _detailsTicket = function (id){
        return $http.get(valueUrl.baseUrl +'/tickets/getTicket?id=' + id);
    };
    var _updateTicket = function (ticket){
        return $http.post(valueUrl.baseUrl +'/tickets/update', ticket)
    };
    var _getStatus = function(){
        return $http.get(valueUrl.baseUrl + '/status/list');
    };
    return  {
        detailsTicket: _detailsTicket,
        updateTicket: _updateTicket,
        getStatus: _getStatus
    }
});