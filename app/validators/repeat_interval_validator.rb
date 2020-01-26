# frozen_string_literal: true

# Validates repeat interval (repeat_from and repeat_to)
class RepeatIntervalValidator < ActiveModel::Validator
  def validate(record)
    return if record.repeat_from && record.repeat_from < record.repeat_to

    record.errors[:repeat_from] << I18n.t('errors.messages.repeat_interval.invalid')
  end
end
