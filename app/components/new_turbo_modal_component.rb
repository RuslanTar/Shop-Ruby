# Deprecated

# frozen_string_literal: true

class NewTurboModalComponent < ViewComponent::Base
  include Turbo::FramesHelper

  def initialize(header:)
    @header = header
  end

end
