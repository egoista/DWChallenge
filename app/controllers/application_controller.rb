# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def current_owner
    Owner.first
  end

  def current_walker
    Walker.first
  end
  
  def record_not_found
    head :not_found
  end

  rescue_from(ActionController::ParameterMissing) do |parameter_missing_exception|
    render json: {
      error: "Required parameter missing: #{parameter_missing_exception.param}"
    }, status: :bad_request
  end
end
