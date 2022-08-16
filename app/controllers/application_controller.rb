class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :restrict_access

  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      Api::AccessToken.exists?(token: token)
    end
  end
end
