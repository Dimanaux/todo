# frozen_string_literal: true

module Api
  # Register users
  class UsersController < ApplicationController
    skip_before_action :authenticate_request, only: [:create]

    def show
      render(json: { id: current_user.id, email: current_user.email })
    end

    def create
      result = Users::Create.call(params)

      if result.success?
        user = result.user
        render(json: { id: user.id, email: user.email }, status: :created)
      else
        render(json: result.to_h.slice(:error), status: :unprocessable_entity)
      end
    end

    def destroy
      # TODO: delete one's account
      @user.destroy
    end

    private

    def user_params
      params.require(:user).permit(:email, :password)
    end
  end
end
