class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(name: params[:session][:access].downcase)
    log_in user
    redirect_to user
  end
  
  def destroy
    log_out
    redirect_to home_path
  end
end
