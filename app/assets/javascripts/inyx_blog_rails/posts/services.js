angular.module('post').factory('posts', [
  '$http', function($http) {
    var posts = {};
    var route_index = '/admin/posts/angular_index.json'
    var route_destroy = '/admin/posts/delete/'


  posts.load = function() {
    Model.get(route_index, $http, function(output){
      posts.data = output;
    });
  };

  posts.destroy = function(ids, $scope) {
    Model.destroy(route_destroy, $http, $scope, ids, function(output){
      Model.get(route_index, $http, function(output){
        posts.data = output;
      });
    });
  };

  return posts;
  }
]);