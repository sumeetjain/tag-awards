// TODO Normalize user_input and theaters to allow case-insensitive matches.
// TODO Prevent the entire feature if user_input is empty.
// TODO Implement for ALL of the theater input fields on the page.

// TODO (Nice to have) Use arrows to cycle through suggestions.

var autocomplete_field = document.getElementById("autocomplete_field");
var nominations_form = document.getElementById("nominations_form");

// whenever someone types into autocomplete_field,
//   check if what they've typed so far matches some theater we know of

autocomplete_field.addEventListener("keyup", function(){
  var theaters = eval(nominations_form.dataset.theaters);

  var user_input = autocomplete_field.value;

  // loop through theaters array
    // if array element contains user_input
      // add it to a temporary storage array for later

  var theater_suggestions = [];

  for (var i = theaters.length - 1; i >= 0; i--) {
    var theater = theaters[i];

    // does theater have user_input in it?
    if (theater.indexOf(user_input) !== -1){
      theater_suggestions.push(theater);
    }
  }

  var html_to_add_to_suggestions_area = "";

  for (var i = theater_suggestions.length - 1; i >= 0; i--) {
    html_to_add_to_suggestions_area += '<div class="autocomplete_suggestion">';
    html_to_add_to_suggestions_area += theater_suggestions[i];
    html_to_add_to_suggestions_area += "</div>";
  }

  var suggestions_area = document.getElementById("suggestions");
  suggestions_area.innerHTML = html_to_add_to_suggestions_area;

  var autocomplete_suggestions = document.getElementsByClassName("autocomplete_suggestion");

  for (var i = autocomplete_suggestions.length - 1; i >= 0; i--) {
    autocomplete_suggestions[i].addEventListener("click", function(event){
      // Get this element's text and replace everything in
      // autocomplete_field with that text.

      var suggestion_text = event.target.textContent;
      autocomplete_field.value = suggestion_text;
    });
  }
});