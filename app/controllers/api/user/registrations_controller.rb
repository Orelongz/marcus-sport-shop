module Api
  module User
    class RegistrationsController < DeviseTokenAuth::RegistrationsController
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
        raise ActiveRecord::RecordInvalid.new(@resource)
      end
    end
  end
end
