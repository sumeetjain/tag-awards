window.addEventListener("load", function(){
	var theater = document.getElementsByClassName("theater_input-theater");
	var theater_options = document.getElementsByClassName("theater_options");

	
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



});