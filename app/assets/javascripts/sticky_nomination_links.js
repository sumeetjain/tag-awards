var nomination_ballot_container = document.getElementsByClassName("nomination_ballot_container");

// If we are on the nomination ballots page...
if (nomination_ballot_container.length > 0){
  var sticky_award_links = document.getElementById("sticky_award_links");

  window.addEventListener("scroll", function(e){
    if(window.scrollY > 93){
      sticky_award_links.classList.add("award_links--sticky");
    }
    else{
      sticky_award_links.classList.remove("award_links--sticky");
    }
  });
}