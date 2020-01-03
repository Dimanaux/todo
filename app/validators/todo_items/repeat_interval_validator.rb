# frozen_string_literal: true

module TodoItems
  # Validates repeat interval (repeat_from and repeat_to)
  class RepeatIntervalValidator < ActiveModel::Validator
    def validate(record)
      return if record.repeat_from < record.repeat_to

      record.errors[:repeat_from] << t('errors.messages.repeat_interval.invalid')
    end
  end
end
