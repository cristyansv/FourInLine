function print(str){
	console.log(str);
}

var casillas = document.querySelectorAll('.casilla');

for (var index = 0; index < casillas.length; index++) {
	var element = casillas[index];
	
	element.addEventListener('click', function(){
		console.log(this);
	})
	
}