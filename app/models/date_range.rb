# frozen_string_literal: true

# Range of timestamps, datetime interval
class DateRange < Range
  def every(step, &_block)
    current_time = self.begin.to_datetime
    end_time = self.end.to_datetime
    less_than = exclude_end? ? :< : :<=

    while current_time.send(less_than, end_time)
      yield current_time
      current_time += step
    end
  end

  def self.of(range)
    DateRange.new(range.begin, range.end, range.exclude_end?)
  end
end
