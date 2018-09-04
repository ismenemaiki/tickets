angular.module('ticketSystem').service('loginAPI',  function ($http, valueUrl){
    this.validate = function (userModel){
        return $http.post(valueUrl.baseUrl + '/users/auth', userModel)
    };
});

