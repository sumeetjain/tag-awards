window.addEventListener("load", function(){

  var showAwardCatExplanation = document.getElementById("show_award_category_explanation");
     
  if (showAwardCatExplanation != null || showAwardCatExplanation != undefined){

    showAwardCatExplanation.addEventListener("click", function() {
      var showAwardCategoryInfo = document.getElementById("showAwardCategoryInfo");

      showAwardCategoryInfo.style.display = "block";    
      var hideAwardText = document.getElementById("hide_award_category_text");
      hideAwardText.style.display = "block";

      hideAwardText.addEventListener("click", function() {
        showAwardCategoryInfo.style.display = "none";
        hideAwardText.style.display = "none";      
      });
    });
  }

  var showSpecialAwards = document.getElementById("show_special_awards_text");
     
  if (showSpecialAwards != null || showSpecialAwards != undefined){
    showSpecialAwards.addEventListener("click", function() {
      var showSpecialAwardsInfo = document.getElementById("showSpecialAwardsInfo");

      showSpecialAwardsInfo.style.display = "block";    
    });
  }  
});
