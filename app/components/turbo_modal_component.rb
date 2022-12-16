# frozen_string_literal: true

class TurboModalComponent < ViewComponent::Base
  include Turbo::FramesHelper

  def initialize(product_name:)
    @product_name = product_name
  end

end
