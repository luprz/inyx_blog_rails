angular.module('category').factory('categories', [
  '$http', function($http) {
    var categories = {};
    var route_index = '/admin/categories/angular_index.json'
    var route_destroy = '/admin/categories/delete/'


  categories.load = function() {
    Model.get(route_index, $http, function(output){
      categories.data = output;
    });
  };

  categories.destroy = function(ids, $scope) {
    Model.destroy(route_destroy, $http, $scope, ids, function(output){
      Model.get(route_index, $http, function(output){
        categories.data = output;
      });
    });
  };

  return categories;
  }
]);