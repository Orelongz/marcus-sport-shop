module Api
  module V1
    class BaseController < ApplicationController
      before_action :authenticate_user!, except: [:index, :show]
    end
  end
end
