# frozen_string_literal: true

module Users
  # Creates user
  class Create
    include Interactor

    before :fail_if_email_taken

    def call
      context.user = User.create!(
        email: context.email,
        password: context.password,
        password_confirmation: context.password
      )
    end

    private

    def fail_if_email_taken
      return unless User.exists?(email: context.email)

      context.fail!(error: I18n.t('errors.messages.email.taken'))
    end
  end
end
