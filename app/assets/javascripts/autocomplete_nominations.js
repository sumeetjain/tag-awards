window.addEventListener("load", function(){
	var theater = document.getElementsByClassName("theater_input-theater");
	var show = document.getElementsByClassName("theater_input-show");

	var theater_options = document.getElementsByClassName("theater_options");
	var show_options = document.getElementsByClassName("show_options");


	
	var theater_request = new XMLHttpRequest();

	theater_request.onreadystatechange = function(response) {
  		if (theater_request.readyState === 4) {
    		if (theater_request.status === 200) {
				var response = JSON.parse(theater_request.response);
				var theater_arr = Object.keys(response.theaters);
				for(i=0; i<theater_arr.length; i++){
						theater_arr[i] = theater_arr[i].split("_").join(" ");
					}
				 

				for(i=0; i<theater_options.length; i++){
					// Loop over the JSON array.
					theater_arr.forEach(function(item) {
				    // Create a new <option> element.
				    	var option = document.createElement('option');
				    // Set the value using the item in the JSON array.
				    	option.value = item;
				    // Add the <option> element to the <datalist>.
				    	theater_options[i].appendChild(option);
					});
				}
			}
		}	
	};

	theater_request.open("get","/fake_data_for_autocomplete.txt");
	theater_request.send();



	for(i=0; i<show.length; i++){
		show[i].addEventListener("mouseenter", function(){
			var id_num = this.getAttribute("list").split("_")[2];
		
			while(show_data.children.length > 0){
				show_data.removeChild(show_data.children[0]);
			}

			var show_request = new XMLHttpRequest();

			show_request.onreadystatechange = function(response) {
				var theater = document.getElementById("theater").value.split(" ").join("_");
		  		if (show_request.readyState === 4) {
		    		if (show_request.status === 200) {
						var response = JSON.parse(show_request.response);
						var show_arr = Object.keys(response.theaters[theater]);

						for(i=0; i<show_arr.length; i++){
							show_arr[i] = show_arr[i].split("_").join(" ");
						}

						// Loop over the JSON array.
						show_arr.forEach(function(item) {
					    // Create a new <option> element.
					    	var option = document.createElement('option');
					    // Set the value using the item in the JSON array.
					    	option.value = item;
					    // Add the <option> element to the <datalist>.
					    	show_data.appendChild(option);
						});
					}
				}	
		};

		show_request.open("get","info.txt");
		show_request.send();

		});
	}




});