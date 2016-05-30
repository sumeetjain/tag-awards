$(document).ready(function(){

  var awardInfoModal = document.getElementById("showAwardCategoryInfo");

  // Get link to show Award Categories Info
  var showAwardInfo = document.getElementById("show_award_category_explanation");

  // Get the <span> "x" that closes the modal
  var closeAwardInfo = document.getElementById("closeAwardInfo");

  // When the user clicks the link, open the modal 
  showAwardInfo.addEventListener("click", function() {
      awardInfoModal.style.display = "block";
  });

  // When the user clicks on <span> (x), close the modal
  closeAwardInfo.addEventListener("click", function() {
      awardInfoModal.style.display = "none";
  });

  // If user clicks anywhere outside of the modal, close it
  $("body").addEventListener("click", function(event) {
      if (event.target == awardInfoModal) {
          awardInfoModal.style.display = "none";
      }
  });

  var specialAwardModal = document.getElementById("showSpecialAwardsInfo");

  // Get link to show Award Categories Info
  var showSpecialInfo = document.getElementById("show_special_awards_text");

  // Get the <span> "x" that closes the modal
  var closeSpecialInfo = document.getElementById("closeSpecialInfo");

  // When the user clicks the link, open the modal 
  showSpecialInfo.addEventListener("click", function() {
      specialAwardModal.style.display = "block";
  });

  // When the user clicks on <span> (x), close the modal
  closeSpecialInfo.addEventListener("click", function() {
      specialAwardModal.style.display = "none";
  });

  // If user clicks anywhere outside of the modal, close it
  $("body").addEventListener("click", function(event) {
      if (event.target == specialAwardModal) {
          awardInfoModal.style.display = "none";
      }
  });
  
});
