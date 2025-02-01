module Api
  module V1
    class BaseController < ActionController::API
      include DeviseTokenAuth::Concerns::SetUserByToken
      include Pundit::Authorization
      include ExceptionHandler

      before_action :authenticate_api_user!

      alias_method :current_user, :current_api_user
    end
  end
end
