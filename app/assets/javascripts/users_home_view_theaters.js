window.addEventListener("load", function(){
	var theaterBtn = document.getElementsByClassName("toggle-btn");
	var showDiv = document.getElementsByClassName("theater-shows");

	for(i=0; i < showDiv.length; i++){
		showDiv[i].style.display = "none";
	}

	showDiv[0].style.display = "inline";
	theaterBtn[0].innerHTML = "-";


	for(i=0; i < theaterBtn.length; i++){
		theaterBtn[i].addEventListener("click", function(btn){
			btn.preventDefault();

			var id = this.getAttribute("id")
			
		});
	}


});