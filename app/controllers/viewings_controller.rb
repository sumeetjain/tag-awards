class ViewingsController < ApplicationController
  before_action :correct_user?

  def update_user
    @user = User.find(params[:id])
    @user.current_voting_period_viewings.delete_all
    @user.insert_viewings params[:play_ids]
    flash[:success] = "Update successful"
    redirect_to user_plays_path(@user)
  end

end
