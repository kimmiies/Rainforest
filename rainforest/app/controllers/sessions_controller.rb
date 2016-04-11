class SessionsController < ApplicationController
  def new
  end

#we don't have to instantiate a user object because we are only logging in, not creating new user

  def create
    user = User.find_by(email: params[:email]) #find email by email user types in
    if user && user.authenticate(params[:password]) #check if user exists & authenticated with password they type in
      session[:user_id] = user.id     #session hash key value pair, # session key has been assigned
      redirect_to products_url
    else
      flash.now[:alert] = "Invalid email or password"
      render "new"
    end
  end

#logging in/setting hash in browser, lets server reference as user navigates through application.
  def destroy
    session[:user_id] = nil
    redirect_to products_url, notice: "Logged out!"
  end
end
