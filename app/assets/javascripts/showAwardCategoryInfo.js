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
  var awardInfoModal = document.getElementById("showAwardCategoryInfo");

  // Get the button that opens the modal
  var showAwardInfo = document.getElementById("show_award_category_explanation");

  // Get the <span> element that closes the modal
  var closeAwardInfo = document.getElementById("closeAwardInfo");

  // When the user clicks the button, open the modal 
  showAwardInfo.addEventListener("click", function() {
      awardInfoModal.style.display = "block";
  });

  // When the user clicks on <span> (x), close the modal
  closeAwardInfo.addEventListener("click", function() {
      awardInfoModal.style.display = "none";
  });

  // When the user clicks anywhere outside of the modal, close it
  window.addEventListener("click", function(event) {
      if (event.target == awardInfoModal) {
          awardInfoModal.style.display = "none";
      }
  });

  var specialAwardModal = document.getElementById("showSpecialAwardsInfo");

  // Get the button that opens the modal
  var showSpecialInfo = document.getElementById("show_special_awards_text");

  // Get the <span> element that closes the modal
  var closeSpecialInfo = document.getElementById("closeSpecialInfo");

  // When the user clicks the button, open the modal 
  showSpecialInfo.addEventListener("click", function() {
      specialAwardModal.style.display = "block";
  });

  // When the user clicks on <span> (x), close the modal
  closeSpecialInfo.addEventListener("click", function() {
      specialAwardModal.style.display = "none";
  });

  // When the user clicks anywhere outside of the modal, close it
  window.addEventListener("click", function(event) {
      if (event.target == specialAwardModal) {
          awardInfoModal.style.display = "none";
      }
  });
  
});
