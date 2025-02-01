module Api
  module User
    class SessionsController < DeviseTokenAuth::SessionsController
      protect_from_forgery unless: -> { request.format.json? }

      def render_create_success
        render(
          json: UserSerializer
            .new(@resource)
            .serializable_hash
            .merge(status: {
              code: 200,
              message: "Logged in successfully"
            })
        )
      end
    end
  end
end
