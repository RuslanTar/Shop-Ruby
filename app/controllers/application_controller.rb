# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  helper_method :current_order
  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_order
    Order.find_or_create_by(user: current_user, status: Order.statuses[:in_progress])
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
