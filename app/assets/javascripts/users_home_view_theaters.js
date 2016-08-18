window.addEventListener("load", function(){
	var theaterBtn = document.getElementsByClassName("toggle_button");
	var showDiv = document.getElementsByClassName("theater_shows");

	for(i=0; i < showDiv.length; i++){
		showDiv[i].style.display = "none";
	}

	showDiv[0].style.display = "inline";

	

	for(i=0; i < theaterBtn.length; i++){
		theaterBtn[i].addEventListener("click", function(){
			
			var id = this.getAttribute("id").split("_")[2];
			var btn = document.getElementById("theater_shows_" + id);
			
			if(btn.style.display == "none"){
				btn.style.display = "inline";
			} 
			else {btn.style.display = "none";
			}

			
		});
	}


});