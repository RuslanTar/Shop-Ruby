# frozen_string_literal: true

class ProductTurboModalComponent < ViewComponent::Base
  include Turbo::FramesHelper

  def initialize(header:)
    @header = header
  end

end
