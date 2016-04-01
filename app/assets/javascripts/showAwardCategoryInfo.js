debugger;  
alert("hello");
window.addEventListener("load", function(){

  var showAwardCatExplanation = document.getElementById("show_award_category_explanation");
     
  // if (showAwardCatExplanation != null || showAwardCatExplanation != undefined){     

  showAwardCatExplanation.addEventListener("click", function() {
    var showAwardCategoryInfo = document.getElementById("showAwardCategoryInfo");

    showAwardCategoryInfo.style.display = "block";    
  });
// }  
});
