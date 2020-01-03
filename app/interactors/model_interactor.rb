# frozen_string_literal: true

# Base interactor for processing models
class ModelInteractor
  def fail_on_record_error
    context.fail!(error: record.errors) if record.errors.messages.any?
  end

  def record
    raise NotImplementedError
  end
end
