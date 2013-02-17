class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :password, :password_confirmation, :username, :email,
                  :token

  EMAIL_REGEX = /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i

  validates_presence_of   :email, message: "cannot be blank"
  validates_presence_of   :username, message: "cannot be blank"
  validates_presence_of   :password_confirmation, 
                           if: :check_password_confirmation?,
                           message: "cannot be blank"

  validates_length_of     :username, in: 5..20, 
                           message: "must be between 5 and 20 characters long"
  validates_length_of     :password, minimum: 8, on: :create,
                           message: "must be atleast 8 characters long"

  validates_uniqueness_of :username, case_sensitive: false,
                           message: "already taken"

  validates_format_of     :email, with: EMAIL_REGEX, message: "invalid email"

  def check_password_confirmation?
    password
  end

  def as_json(options = {})
    {
      email: email,
      username: username,
      created_at: created_at,
      token: token
    }
  end
end
