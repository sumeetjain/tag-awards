window.addEventListener("load", function(){
	var theater = document.getElementsByClassName("theater_input-theater");

	for(i=0; i<theater.length; i++){
		theater[i].addEventListener("click", function(){
			alert("hello");
		});
		
	}



});