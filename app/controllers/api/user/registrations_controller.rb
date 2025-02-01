module Api
  module User
    class RegistrationsController < DeviseTokenAuth::RegistrationsController
      protect_from_forgery unless: -> { request.format.json? }

      def render_create_success
        render json: UserSerializer
          .new(@resource)
          .serializable_hash
          .merge(status: {
            code: 200,
              message: "Signed up successfully"
          })
      end

      def render_create_error
        render json: {
          message: "Validation Failed",
          errors: @resource.errors.full_messages
        }, status: :unprocessable_entity
      end
    end
  end
end
