//= require jquery
//= require jquery_ujs
//= require selectize
//= require moment
//= require datetime_picker
//= require_tree .

window.addEventListener("load", function () {

  document.getElementById("potential_nomination_nominatable_id").addEventListener("change", nominatable_selected);

  var event = new Event('change');
  document.getElementById("potential_nomination_nominatable_id").dispatchEvent(event);
  
});

function nominatable_selected(e) {
  var selected_type = e.target.selectedOptions[0].parentElement.label
  var nom_type_input = document.getElementById("nominatable_type");
  nom_type_input.value = selected_type;
}

