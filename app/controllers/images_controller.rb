class ImagesController < ApplicationController
  respond_to :html, :json

  def index
    @images = Image.where(user_id: params[:user_id])

    respond_with @images
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

    respond_with @image
  end
end
