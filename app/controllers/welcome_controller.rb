class WelcomeController < ApplicationController
  def index
    session[:page] = 'Home'
    if session[:user_id] != nil
      redirect_to user_path(session[:user_id])
    end
  end
  
  def fail
  end
end

