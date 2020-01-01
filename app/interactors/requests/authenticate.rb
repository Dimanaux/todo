# frozen_string_literal: true

module Requests
  # Authenticates request and provides user.
  # Identifies user by provided jwt!
  class Authenticate
    include Interactor

    before :decode_jwt

    def call
      context.user = User.new(@user_data)
    end

    def decode_jwt
      @user_data = Jwt.decode(context.jwt)
    rescue JWT::DecodeError, JWT::VerificationError
      context.fail!(error: I18n.t('errors.messages.token.invalid'))
    end
  end
end
