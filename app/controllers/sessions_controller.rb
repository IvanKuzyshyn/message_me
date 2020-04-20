class SessionsController < ApplicationController
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
end
