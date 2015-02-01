angular.module('post').directive('whenScrolled', function() {
  return function(scope, elm, attr) {
    $(function () {
			var $win = $(window);

			$win.scroll(function () {
				if ($win.height() + $win.scrollTop()== $(document).height()) {
			 		scope.$apply(attr.whenScrolled); 	
			 	}
			});
		});    
  };
});