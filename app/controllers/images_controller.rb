class ImagesController < ApplicationController
  respond_to :html, :json

  def index
    if current_user
      @images = Image.where(user_id: params[:user_id])
      respond_with @images
    else
      redirect_to login_path
    end
  end

  def new
    @image = current_user.images.new()
  end

  def create
    @image = current_user.images.new(params[:image])

    if @image.save
      redirect_to user_images_path(current_user)
    else
      flash.now[:error] = @image.errors.full_messages.first
      render 'new'
    end
  end

  def show
    @image = Image.find(params[:id])

    if current_user == @image.user
      respond_with @image
    else
      redirect_to login_path
    end
  end
end
