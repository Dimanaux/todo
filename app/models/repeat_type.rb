# frozen_string_literal: true

# Base class for repeat types
class RepeatType
  private_class_method :new

  attr_reader :repeat_interval

  def between(date_from, date_to, &block)
    DateRange.of(date_from..date_to).every(repeat_interval, &block)
  end

  def self.of(label)
    LABEL_TO_REPEAT_TYPE[label.to_sym]
  end

  def self.types
    LABEL_TO_INTERVAL.keys
  end

  private

  def initialize(interval)
    @repeat_interval = interval
  end

  LABEL_TO_INTERVAL = {
    once: 2_147_483_647.days,
    daily: 1.day,
    weekly: 1.week,
    monthly: 1.month,
    annually: 1.year
  }.freeze

  LABEL_TO_REPEAT_TYPE = LABEL_TO_INTERVAL.transform_values { |v| RepeatType.new(v) }.freeze
end
