class Picture < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  attr_accessible :image, :user_id


end
