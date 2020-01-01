# frozen_string_literal: true

module Api
  # Register users
  class UsersController < ApplicationController
    skip_before_action :authenticate_request, only: [:create]

    def show
      render json: current_user
    end

    def create
      result = Users::Create.call(params)

      if result.success?
        render json: result.user, status: :created
      else
        render json: result.to_h.slice(:error), status: :unprocessable_entity
      end
    end

    def destroy
      # TODO: think: client still can store token after
      # account deletion and is recognized, so it can
      # get internal errors (500) instead of unauthorized (401)
      current_user.reload
      current_user.destroy
    end

    private

    def user_params
      params.require(:user).permit(:email, :password)
    end
  end
end
