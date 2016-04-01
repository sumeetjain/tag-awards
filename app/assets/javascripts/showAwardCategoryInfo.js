window.onload = function(){

  // if (showAwardCatExplanation != null || showAwardCatExplanation != undefined){ 
    var showAwardCatExplanation = document.getElementById("show_award_category_explanation");

    var showAwardCategoryInfo = document.getElementById("showAwardCategoryInfo");

    showAwardCatExplanation.addEventListener("click", function() { 
      showAwardCategoryInfo.style.display = "block";    
    });

  // }
};