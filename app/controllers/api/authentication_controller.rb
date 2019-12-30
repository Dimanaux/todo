# frozen_string_literal: true

module Api
  # Logs in users, gives them tokens
  class AuthenticationController < ApplicationController
    skip_before_action :authenticate_request, only: [:create]

    def create
      result = Users::Authenticate.call(params)

      if result.success?
        render(json: result.to_h.slice(:jwt))
      else
        render(json: result.to_h.slice(:error), status: :bad_request)
      end
    end

    private

    def authentication_params
      params.require(:user).permit(:email, :password)
    end
  end
end
