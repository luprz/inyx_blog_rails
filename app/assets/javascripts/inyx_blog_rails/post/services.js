angular.module('post').factory('posts', [
  '$http', function($http) {
    var posts = {};
    var route_index = '/admin/blog/posts/angular_index.json'
    var route_destroy = '/admin/blog/posts/delete/'


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