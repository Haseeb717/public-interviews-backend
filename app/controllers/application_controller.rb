# frozen_string_literal: true

class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  def json_response(object, status = :ok)
    render json: object, status: status
  end
end
