class Tag < ActiveRecord::Base
  attr_accessible :xpos, :ypos, :user_id, :image_id

  validates_presence_of :user_id
  validates_presence_of :image_id

  belongs_to :image
  belongs_to :user

  def as_json(options = {})
    {
      id: id,
      user: user.username,
      user_id: user_id,
      image_id: image_id,
      xpos: xpos,
      ypos: ypos
    }
  end

end
