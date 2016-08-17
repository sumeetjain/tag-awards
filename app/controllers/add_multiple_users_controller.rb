class AddMultipleUsersController < ApplicationController
  before_action :set_add_multiple_user, only: [:show, :edit, :update, :destroy]

  # GET /add_multiple_users
  def index
    @add_multiple_users = AddMultipleUser.all
  end

  # GET /add_multiple_users/1
  def show
  end

  # GET /add_multiple_users/new
  def create

    @add_multiple_user = AddMultipleUser.new
    @add_multiple_user.save 
      redirect_to "/add_multiple_users", notice: "Add #{@add_multiple_user.count} users was 
      successfully created. The following rows failed #{@add_multiple_user.failed}. If any 
      rows failed please create new csv file and correct the issue."
  end

  # PATCH/PUT /add_multiple_users/1
  def update
    if @add_multiple_user.update(add_multiple_user_params)
      redirect_to @add_multiple_user, notice: 'Add multiple user was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /add_multiple_users/1
  def destroy
    @add_multiple_user.destroy
    redirect_to add_multiple_users_url, notice: 'Add multiple user was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_add_multiple_user
      @add_multiple_user = AddMultipleUser.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def add_multiple_user_params
      params[:add_multiple_user]
    end
end
