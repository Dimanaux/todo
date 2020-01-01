# frozen_string_literal: true

module Users
  # Authenticates user with login and password and provides jwt
  class Authenticate
    include Interactor

    before :authenticate

    def call
      token = Jwt.encode(id: @user.id, email: @user.email)
      context.token = context.jwt = token
    end

    private

    def authenticate
      @user = User.find_by(email: context.email)
      return if @user&.authenticate(context.password)

      context.fail!(error: I18n.t('errors.messages.credentials.invalid'))
    end
  end
end
