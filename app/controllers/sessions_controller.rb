class SessionsController < ApplicationController
  def new
    redirect_to user_path(current_user) if current_user

    @user = User.new
  end

  def create
    @user = User.find_by_username(params[:user][:username])

    if @user && @user.authenticate(params[:user][:password])
      build_cookie(@user)
      redirect_to user_path(@user)
    else
      flash.now[:error] = "Incorrect Username/Password"
      render 'new'
    end
  end

  def destroy
    delete_cookie
    redirect_to login_path
  end

end
