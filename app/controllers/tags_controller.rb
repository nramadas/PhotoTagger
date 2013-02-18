class TagsController < ApplicationController
  respond_to :html, :json

  def index
    @tags = Tag.where(image_id: params[:image_id])

    respond_with @tags
  end

  def create
    @tag = Tag.create!(params[:tag])

    respond_with @tag
  end

end
