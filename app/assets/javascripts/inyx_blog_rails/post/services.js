angular.module('post').factory('obj', [
  '$http', function($http) {
    var obj = {};

    obj.get_subcategories = function(id) {
      $http.get('/admin/angular/category/'+id+"/subcategories.json").success(function(data) {
        console.log('Successfully subcategories');
        obj.subcategories = data;
      }).error(function() {
        console.error('Failed to subcategories.');
      });
    }

  return obj;
  }

]);