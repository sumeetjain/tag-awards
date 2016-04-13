window.addEventListener("load", function(){

  // var showAwardCatExplanation = document.getElementById("show_award_category_explanation");
     
  // if (showAwardCatExplanation != null || showAwardCatExplanation != undefined){

  //   showAwardCatExplanation.addEventListener("click", function() {
  //     var showAwardCategoryInfo = document.getElementById("showAwardCategoryInfo");

  //     showAwardCategoryInfo.style.display = "block";
  //     showAwardCatExplanation.style.display = "none";

  //     var hideAwardText = document.getElementById("hide_award_category_text");
  //     hideAwardText.style.display = "block";

  //     hideAwardText.addEventListener("click", function() {
  //       showAwardCategoryInfo.style.display = "none";
  //       hideAwardText.style.display = "none"; 
  //       showAwardCatExplanation.style.display = "block";     
  //     });
  //   });
  // }
var modal = document.getElementById("showAwardCategoryInfo");

// Get the button that opens the modal
var showAwardInfo = document.getElementById("show_award_category_explanation");

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];

// When the user clicks the button, open the modal 
showAwardInfo.onclick = function() {
    modal.style.display = "block";
}

// When the user clicks on <span> (x), close the modal
span.onclick = function() {
    modal.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}

  // var showSpecialAwards = document.getElementById("show_special_awards_text");
     
  // if (showSpecialAwards != null || showSpecialAwards != undefined){
  //   showSpecialAwards.addEventListener("click", function() {
  //     var showSpecialAwardsInfo = document.getElementById("showSpecialAwardsInfo");

  //     showSpecialAwardsInfo.style.display = "block";
  //     showSpecialAwards.style.display = "none";

  //     var hideSpecialText = document.getElementById("hide_special_awards_text");
  //     hideSpecialText.style.display = "block";

  //     hideSpecialText.addEventListener("click", function() {
  //       showSpecialAwardsInfo.style.display = "none";
  //       hideSpecialText.style.display = "none"; 
  //       showSpecialAwards.style.display = "block";     
  //     });      
  //   });
  // }
  
});
