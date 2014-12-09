angular.module('categoryPost', [])
  .controller('indexCategoryPostCtrl', ['$scope','categories', function($scope, categories) {
 			categories.load();
 			$scope.categories = categories;
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
			  return '/admin/posts/categories/' + id;
			};

			$scope.destroy_path = function (id) {
			  return '/admin/posts/categories/' + id;
			};
			// --------------------

			$scope.init = function(){
				ctrl.pages = {};
			}

			$scope.destroy = function() {	
			 	if (confirm("¿Deseas eliminar los mensajes seleccionados?") == true) {
				 	categories.destroy(ctrl.selected, $scope);
				 	ctrl.pageInit($scope);
 					$scope.categories = categories;
				}
			};

			$scope.selected = function(id){
				ctrl.itemSelected(id, $scope);
			};	

			$scope.allSelected = function(){
				ctrl.allItemsSelected($scope, $scope.categories);
			};

			$scope.refresh = function() {
				categories.load();
				$scope.categories = categories;				
				ctrl.pageInit($scope);
			};

			$scope.nextList = function(){
				ctrl.paginateControl($scope, $scope.categories.data.length, "next");
			}

			$scope.lastList = function(){
				ctrl.paginateControl($scope, "last");			
			}

			$scope.alertClose = function(){
				$scope.alert = false;
			}

  }]);

  

