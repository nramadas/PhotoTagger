class UsersController < ApplicationController
  def index
    @users = User.all

    respond_to do |format|
      format.json { render json: @users }
    end
  end

  def new
    redirect_to user_path(current_user) if current_user

    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      build_cookie(@user)
      redirect_to user_path(@user)
    else
      flash.now[:error] = @user.errors.full_messages.first
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])

    if @user == current_user
      respond_to do |format|
        format.html
        format.json { render json: @user }
      end
    else
      redirect_to login_path
    end
  end

end
