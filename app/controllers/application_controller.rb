# encoding: utf-8
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :authorize
  protect_from_forgery with: :exception

  protected
  def authorize
    user = Origin::User.find_by_id(session[:user_id])
    unless !CC_LOGIN_ENABLE || user
      redirect_to origin_login_url, :notice => '请登录'
      return
    end

    return if user.role.adminFlag
    return if params[:controller].include?('static_pages')

    user.sidebar_items.each do |item|
      return if item.url.include?(params[:controller])
    end
    redirect_to static_pages_403_path
  end

  # Set a filter that is invoked on every request
  before_filter :_set_current_session

  protected
  def _set_current_session
    # Define an accessor. The session is always in the current controller
    # instance in @_request.session. So we need a way to access this in
    # our model
    accessor = instance_variable_get(:@_request)

    # This defines a method session in ActiveRecord::Base. If your model
    # inherits from another Base Class (when using MongoMapper or similar),
    # insert the class here.
    ActiveRecord::Base.send(:define_method, "session", proc { accessor.session })
  end
end