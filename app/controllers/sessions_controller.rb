class SessionsController < ApplicationController
  before_action :logged_in_redirect, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: create_params[:email])

    if user && user.authenticate(create_params[:password])
      session[:user_id] = user.id
      flash[:success] = "You are successfully logged in"

      redirect_to root_path
    else
      flash.now[:error] = "Wrong credentials"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You are logged out"

    redirect_to login_path
  end

  private

  def create_params
    params[:session]
  end

  def logged_in_redirect
    if logged_in?
      flash[:error] = "You are already logged in"
      redirect_to root_path
    end
  end
end
