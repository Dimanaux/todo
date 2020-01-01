# frozen_string_literal: true

# Provides a facade to JWT
class Jwt
  class << self
    def encode(payload)
      JWT.encode(payload, Rails.application.secrets.secret_key_base, 'HS256')
    end

    def decode(token)
      body = JWT.decode(token,
                        Rails.application.secrets.secret_key_base,
                        true,
                        algorithm: 'HS256')[0]
      HashWithIndifferentAccess.new(body)
    end
  end
end
