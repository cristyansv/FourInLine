angular.module('fourline', [])
    .controller('four', ['$scope', '$http', function ($scope, $http) {

		$scope.arreglo = [];
		
		for(var i=1; i<8; i++){
			var colum = [];
			for(var k=1; k<7; k++){
				colum.push({
					name:"C"+i+"F"+k
				});
			}
			$scope.arreglo.push(colum);
		}
		
		$scope.casilla = function(){
			console.log(this);
		}

	}]);