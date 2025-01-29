class ValidationErrorSerializer
  attr_reader :record

  def initialize(record)
    @record = record
  end

  def serialize
    @record.errors.messages.map do |field, message|
      {
        resource: @record.class.name,
        field: field,
        code: message
      }
    end
  end
end
