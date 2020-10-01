# frozen_string_literal: true

# module Valid
module Valid
  def valid?
    validate!
    true
  rescue StandardError
    false
  end
end
