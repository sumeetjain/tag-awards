//= require jquery
//= require jquery_ujs
//= require selectize
//= require moment
//= require datetime_picker
//= require_tree .

window.addEventListener("load", function () {

  document.getElementById("potential_nomination_nominatable").addEventListener("change", nominatable_selected);
  
});

function nominatable_selected(e) {
  var selected_type = e.target.selectedOptions[0].dataset["type"];
  var nom_type_input = document.getElementById("nominatable_type");
  nom_type_input.value = selected_type;
}