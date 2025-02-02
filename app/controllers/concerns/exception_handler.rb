module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
    rescue_from Pundit::NotAuthorizedError, with: :not_authorized_response
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_response
    rescue_from ApplicationRaisedError, with: :application_raised_error_response
  end

  private

  def not_found_response
    render(
      json: {
        message: "Not found",
        code: "not_found"
      },
      status: :not_found
    )
  end

  def not_authorized_response
    render(
      json: {
        message: "Not authorized",
        code: "not_authorized"
      },
      status: :forbidden
    )
  end

  def unprocessable_entity_response(exception)
    render(
      json: {
        message: "Validation Failed",
        errors: ValidationErrorSerializer.new(exception.record).serialize
      },
      status: :unprocessable_entity
    )
  end

  def application_raised_error_response(exception)
    render(
      json: { message: exception.message },
      status: :unprocessable_entity
    )
  end
end
