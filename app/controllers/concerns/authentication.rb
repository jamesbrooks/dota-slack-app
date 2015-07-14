module Authentication
  extend ActiveSupport::Concern

  included do
    before_filter :require_authenticated_user
    helper_method :current_user
  end


protected
  def current_user
    @current_user ||= User.find(session[:current_user_id]) if session[:current_user_id]

  rescue
    nil
  end

  def login!(user)
    @current_user = user
    session[:current_user_id] = user.id
  end

  def logout!
    @current_user = nil
    reset_session
  end

  def logged_in?
    !!current_user
  end

  def require_authenticated_user
    unless logged_in?
      session[:return_to] ||= request.url
      redirect_to '/login'
      false
    end
  end

  def back_or_default(url)
    session.delete(:return_to) || url
  end
end
