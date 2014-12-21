angular.module('post', ['ngSanitize', 'ui.bootstrap'])

	.controller('formCategoryCtrl', ['$scope','obj', function($scope, object) {
		$scope.obj = object;


		$scope.init = function(category_id, post_id, post, subcategories) {
			object.get_subcategories(category_id)
			$scope.post = post;
			$scope.subcategories = subcategories;
			if(post) { $scope.selected = selectSubcategory(post, subcategories) }
		}

		$scope.selectAction = function() {
		  object.get_subcategories($scope.post.category_id);
		  console.log($scope.post.category_id)
		  $scope.selected = "";

		}

		selectSubcategory = function(post, subcategories) {
			var	selected = 0;
			for (var i = 0; i < subcategories.length; i++) {
			   if(post.subcategory_id == subcategories[i].id) {
			   		return i;
			   }
			}
		}

		
  }])

	function frontIndexCtrl($scope, filterFilter) {

		$scope.init = function(posts) {			
			$scope.posts = posts;
		}

		$scope.currentPage = 1; //current page
    $scope.maxSize = 5; //pagination max size
    $scope.entryLimit = 6; //max rows for data table
    
    $scope.$watch('search', function(term) {
	    $scope.filtered = filterFilter($scope.posts, term);
	    $scope.noOfPages = Math.ceil($scope.filtered.length/$scope.entryLimit);
    })

  }