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

	.controller('frontIndexCtrl', ['$scope','obj', function($scope, object) {
	  $scope.filteredposts = []
	  ,$scope.currentPage = 1
	  ,$scope.numPerPage = 1
	  ,$scope.maxSize = 5;
	  
		$scope.init = function(posts) {			
			$scope.posts = posts;
			$scope.totalItems = posts.length;
		}

		$scope.numPages = function () {
	    return Math.ceil($scope.totalItems / $scope.numPerPage);
	  }
	  
	  $scope.$watch('currentPage + numPerPage', function() {
	    var begin = (($scope.currentPage - 1) * $scope.numPerPage)
	    , end = begin + $scope.numPerPage;
	    
	    $scope.filteredposts = $scope.posts.slice(begin, end);
	  })

  }])


  

  

