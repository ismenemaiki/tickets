angular.module('ticketSystem').controller('loginController', loginController)

function loginController($scope, $state, loginAPI, localStorageService) {
    var vm = this;
    $scope.loggerUser = localStorageService.get('user');

    vm.signin = function (user, pass) {
        var user = {
            username: user,
            password: pass
        };
        loginAPI.validate(user).then(function (response) {
            localStorageService.set('user',response.data);
            switch (response.data.typeId) {
                case 1:
                    $state.go('employee');
                    break;
                case 2:
                    $state.go('attendant');
                    break;
                default:
                    $scope.message = "user and/or password incorrect";
            }
        }).catch(function () {
            $scope.message = "login error";
        });
    };
}
