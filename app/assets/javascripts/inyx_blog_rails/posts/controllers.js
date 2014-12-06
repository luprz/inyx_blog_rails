angular.module('post', [])
  .controller('indexPostCtrl', ['$scope','posts', function($scope, posts) {
 			posts.load();
 			$scope.posts = posts;
			$scope.interval_a = 0;
			$scope.interval_b = 10;
			$scope.page = 1;
			$scope.btnDelete = false;
			$scope.public = { true: "Publicado", false: "Despublicado" } 
			//Alerts
			$scope.alert = false;
			$scope.msnAlert = "Exitosamente!";
			$scope.statusAlert="success";

			// routes path
			$scope.update_path = function (id) {
			  return '/admin/posts/' + id;
			};

			$scope.destroy_path = function (id) {
			  return '/admin/posts/' + id;
			};
			// --------------------

			$scope.init = function(){
				ctrl.pages = {};
			}

			$scope.destroy = function() {	
			 	if (confirm("¿Deseas eliminar los mensajes seleccionados?") == true) {
				 	posts.destroy(ctrl.selected, $scope);
				 	ctrl.pageInit($scope);
 					$scope.posts = posts;
				}
			};

			$scope.selected = function(id){
				ctrl.itemSelected(id, $scope);
			};	

			$scope.allSelected = function(){
				ctrl.allItemsSelected($scope, $scope.posts);
			};

			$scope.refresh = function() {
				posts.load();
				$scope.posts = posts;				
				ctrl.pageInit($scope);
			};

			$scope.nextList = function(){
				ctrl.paginateControl($scope, $scope.posts.data.length, "next");
			}

			$scope.lastList = function(){
				ctrl.paginateControl($scope, "last");			
			}

			$scope.alertClose = function(){
				$scope.alert = false;
			}

  }]);

  

