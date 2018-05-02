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
        log_out
        redirect_to welcome_index_path
      end
    #new user stuff
    else
      if User.find_by(uid: request.env["omniauth.auth"][:uid])
        flash[:notice] = 'You already have an account'
        log_out
        redirect_to welcome_index_path
      else
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
