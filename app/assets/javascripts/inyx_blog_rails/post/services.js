angular.module('post').factory('obj', [
  '$http', function($http) {
    var obj = {};

    obj.get_subcategories = function(id) {
      $http.get('/admin/angular/category/'+id+"/subcategories.json").success(function(data) {
        console.log('Successfully subcategories');
        obj.subcategories = data;
      }).error(function() {
        obj.subcategories = null;
        console.error('Failed to subcategories.');
      });
    }

    obj.load_more = function($scope, offset) {
      $http({
        url: location.href+".json", 
        method: "GET",
        params: { offset: offset }
      }).success(function(data) {
        for(var index in data) {
          $scope.posts.push(data[index])
        }
        console.log("load more")
      }).error(function() {
        console.log("Failed")
      });
    }

  return obj;
  }

]);