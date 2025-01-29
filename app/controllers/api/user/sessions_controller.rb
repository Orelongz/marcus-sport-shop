module Api
  module User
    class SessionsController < DeviseTokenAuth::SessionsController
      def render_create_success
        render(
          json: {
            status: {
              code: 200,
              message: "Logged in successfully"
            },
            data: UserSerializer.new(@resource).serializable_hash
          }
        )
      end
    end
  end
end
