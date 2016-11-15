class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(name: params[:user][:name]) # not unique
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      flash[:notice] = 'You have signed in'
      redirect_to '/' # or root_url
    else
      flash[:error] = 'Wrong name/password combination'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'You have signed out'
    redirect_to root_url
  end
end
