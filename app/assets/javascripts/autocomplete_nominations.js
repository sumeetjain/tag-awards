window.addEventListener("load", function(){
	var theater = document.getElementsByClassName("theater_input-theater");
	var show = document.getElementsByClassName("theater_input-show");
	var nominee = document.getElementsByClassName("theater_input-nominee");
	var role = document.getElementsByClassName("theater_input-role");

	var theater_options = document.getElementsByClassName("theater_options");
	


	
	var theater_request = new XMLHttpRequest();

	theater_request.onreadystatechange = function(response) {
  		if (theater_request.readyState === 4) {
    		if (theater_request.status === 200) {
				var response = JSON.parse(theater_request.response);
				var theater_arr = Object.keys(response.theaters);
				 

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
			var list_id_num = this.getAttribute("list").split("_")[2];
			var show_options = document.getElementById("show_options_" + list_id_num);

		
			while(show_options.children.length > 0){
				show_options.removeChild(show_options.children[0]);
			}

			var show_request = new XMLHttpRequest();

			show_request.onreadystatechange = function(response) {
				var theater_input = document.getElementById("theater_input_" + list_id_num).value;
		  		if (show_request.readyState === 4) {
		    		if (show_request.status === 200) {
						var response = JSON.parse(show_request.response);
						var show_arr = Object.keys(response.theaters[theater_input]);


						// Loop over the JSON array.
						show_arr.forEach(function(item) {
					    // Create a new <option> element.
					    	var option = document.createElement('option');
					    // Set the value using the item in the JSON array.
					    	option.value = item;
					    // Add the <option> element to the <datalist>.
					    	show_options.appendChild(option);
						});
					}
				}	
		};

		show_request.open("get","/fake_data_for_autocomplete.txt");
		show_request.send();

		});
	}





	for(i=0; i<nominee.length; i++){
		nominee[i].addEventListener("mouseenter", function(){
			var list_id_num = this.getAttribute("list").split("_")[2];
			var nominee_options = document.getElementById("nominee_options_" + list_id_num);

		
			while(nominee_options.children.length > 0){
				nominee_options.removeChild(nominee_options.children[0]);
			}

			var nominee_request = new XMLHttpRequest();

			nominee_request.onreadystatechange = function(response) {
				var theater_input = document.getElementById("theater_input_" + list_id_num).value;
				var show_input = document.getElementById("show_input_" + list_id_num).value;
		  		if (nominee_request.readyState === 4) {
		    		if (nominee_request.status === 200) {
						var response = JSON.parse(nominee_request.response);
						var nominee_arr = Object.keys(response.theaters[theater_input][show_input]);


						// Loop over the JSON array.
						nominee_arr.forEach(function(item) {
					    // Create a new <option> element.
					    	var option = document.createElement('option');
					    // Set the value using the item in the JSON array.
					    	option.value = item;
					    // Add the <option> element to the <datalist>.
					    	nominee_options.appendChild(option);
						});
					}
				}	
		};

		nominee_request.open("get","/fake_data_for_autocomplete.txt");
		nominee_request.send();

		});
	}



});