# frozen_string_literal: true

# Base controller
class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def authenticate_request
    result = Requests::Authenticate.call(jwt: request.headers['Authorization'])
    if result.success?
      @current_user = result.user
    else
      render json: result.to_h.slice(:error), status: :unauthorized
    end
  end

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    error = I18n.t("#{policy_name}.#{exception.query}", scope: 'pundit', default: exception.message)
    render json: { error: error }, status: :forbidden
  end
end
