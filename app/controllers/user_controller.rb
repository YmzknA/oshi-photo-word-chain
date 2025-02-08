class UserController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @from_post_index = false
  end

end
