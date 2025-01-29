class ApplicationController < ActionController::API
  include Pundit::Authorization
  include ExceptionHandler
  include DeviseTokenAuth::Concerns::SetUserByToken
end
