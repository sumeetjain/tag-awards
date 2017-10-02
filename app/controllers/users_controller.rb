class UsersController < ApplicationController
  before_action :correct_user?

  def plays

  end

  def edit
    @user = User.find(params[:id])
  end

  def update_email
    @user = User.find(params[:id])
    if @user.update_attributes(email)
      flash[:success] = "Email successfully updated"
      redirect_to user_plays_path(@user)
    else
      render 'edit'
    end
  end

  def update_password
    @user = User.find(params[:id])
    if @user.update_attributes(password)
      flash[:success] = "Password successfully updated"
      redirect_to user_plays_path(@user)
    else
      render 'edit'
    end
  end

  private

    def password
      params.require(:user).permit(:password, :password_confirmation)
    end

    def email
      params.require(:user).permit(:email)
    end
end
