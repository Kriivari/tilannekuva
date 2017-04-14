class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
  def authenticate
    if Rails.configuration.use_basic_auth
      authenticate_or_request_with_http_basic do |username, password|
        username == Rails.configuration.basic_auth_user && password == Rails.configuration.basic_auth_password
      end
    else
      authenticate_user!
    end
  end
end
