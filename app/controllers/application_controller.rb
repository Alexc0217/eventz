class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def require_signin
    unless current_user
      session[:intended_url] = request.url
      redirect_to new_session_url, alert: "Please sign in first!"
    end
  end

  def is_author?(user_id)
    current_user.id == user_id
  end

  helper_method :is_author?

  def require_admin
    unless current_user.admin?
      redirect_to events_url, alert: "Unauthorized access!"
    end
  end

  def current_user_admin?
    current_user.try(:admin?)
  end

  helper_method :current_user_admin?
end
