class VotesController < ApplicationController

# TODO: This definitely feels like a solid example of times when I will want to use a presenter object. Will refactor after I get the basics working.
  
  def ballots_page
    @all_ballot_items = BallotItem.all 
    # Really you'll want something like BallotItem.all.awards in case of rogue award categories.  
    @awards = Award.all # This probably won't work in case there is a rogue ballot item that does not have an award_id.....TODO: Fix that. 
  end


end