module Api
  class BaseController < ActionController::API
    include DeviseTokenAuth::Concerns::SetUserByToken
    include Pundit::Authorization
    include ExceptionHandler

    include ActionController::Cookies

    before_action :authenticate_api_user!
    before_action :set_default_response_format

    alias_method :current_user, :current_api_user

    private

    def set_default_response_format
      request.format = :json
    end
  end
end
