# frozen_string_literal: true

# Base controller
class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user

  private

  def authenticate_request
    result = Requests::Authenticate.call(jwt: request.headers['Authorization'])
    if result.success?
      @current_user = result.user
    else
      render(json: result.to_h.slice(:error), status: 401)
    end
  end
end
