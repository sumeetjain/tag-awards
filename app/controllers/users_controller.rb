class UsersController < ApplicationController

def dashboard
  @user = User.all
  render "index"
end


end