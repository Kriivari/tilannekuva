class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
  def authenticate
    if Rails.configuration.use_basic_auth
      authenticate_or_request_with_http_basic do |username, password|
        username == "risti" && password == "sparra"
      end
    else
      authenticate_user!
  end
end
