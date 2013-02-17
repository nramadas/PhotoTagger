class Image < ActiveRecord::Base
  attr_accessible :image_data

  mount_uploader :image_data, ImageUploader

  validates_presence_of :user_id, message: "must be present"
  validates_presence_of :image_data, message: "must exist"

  belongs_to :user

end
