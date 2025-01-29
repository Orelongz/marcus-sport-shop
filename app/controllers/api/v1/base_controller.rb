module Api
  module V1
    class BaseController < ApplicationController
      before_action :authenticate_api_user!

      alias_method :current_user, :current_api_user
    end
  end
end
