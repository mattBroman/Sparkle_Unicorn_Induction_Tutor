class SessionsController < ApplicationController
  def new
    session[:page] = "Login"
  end
  
  def create
    user = User.find_by(id: params[:session][:id])
    log_in user
    redirect_to user
  end
  
  def destroy
    log_out
    redirect_to home_path
  end
end
