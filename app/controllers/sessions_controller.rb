class SessionsController < ApplicationController

  def new
    session[:page] = "Login"
  end
  
  def create
    unless session[:new_user]
      @user = User.find_by(uid: request.env["omniauth.auth"][:uid])
      if @user
        log_in @user
        redirect_to @user
      else
        flash[:notice] = 'failed to login.'
        redirect_to welcome_index_path
      end
    #new user stuff
    else
      if session[:google]
        session[:google] = nil
        redirect_to google_path
      else
        if User.find_by(uid: request.env["omniauth.auth"][:uid])
          flash[:notice] = 'You already have an account'
          redirect_to welcome_index_path
        end
        session[:new_user] = nil
        @user = User.find(session[:user_id])
        @user.name = request.env["omniauth.auth"][:info][:name]
        @user.uid = request.env["omniauth.auth"][:uid]
        @user.save
        log_in @user
        redirect_to @user
      end
    end
  end
  
  def destroy
    log_out
    redirect_to home_path
  end
end
