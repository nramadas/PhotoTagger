class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    return nil if cookies[:user_id].blank?
    return nil if cookies[:token].blank?
    user = User.find(cookies[:user_id])
    return nil unless user
    return nil unless user.token.reverse == cookies[:token]
    user
  end

  def build_cookie(user)
    cookies[:user_id] = user.id
    user.update_attributes(token: SecureRandom.uuid)
    cookies[:token] = user.token.reverse
  end

  def delete_cookie
    current_user.update_attributes(token: nil)
    cookies.delete(:user_id)
    cookies.delete(:token)
  end
end
