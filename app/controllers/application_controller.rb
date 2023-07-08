class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    return unless session[:user_id]

    User.find(session[:user_id])
  end

  def ensure_current_user
    return unless current_user.nil?

    redirect_to root_path
  end
end
