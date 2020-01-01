# frozen_string_literal: true

# Shortcuts for response.body
module JsonHelpers
  # parsed response body
  def response_body
    JSON.parse(response.body)
  end

  # Sorts array of hashes by 'id' key
  refine Array do
    def sorted
      sort_by { |h| h['id'] }
    end
  end
end
