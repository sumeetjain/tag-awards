window.addEventListener("load", function(){
	var theaterBtn = document.getElementsByClassName("toggle_btn");
	var plays_list = document.getElementsByClassName("theater_shows");

	for(i=0; i < plays_list.length; i++){
		plays_list[i].style.display = "none";
	}

	plays_list[0].style.display = "inline";
	theaterBtn[0].innerHTML = "-";

	

	for(i=0; i < theaterBtn.length; i++){
		theaterBtn[i].addEventListener("click", function(){
			
			var id = this.getAttribute("id").split("_")[2];
			var play_l = document.getElementById("theater_shows_" + id);
			var btn = document.getElementById("toggle_btn_" + id);
			
			if(play_l.style.display == "none"){
				play_l.style.display = "inline";
				btn.innerHTML = "-";
			} 
			else { 
				play_l.style.display = "none";
				btn.innerHTML = "+";
			}

			
		});
	}


});