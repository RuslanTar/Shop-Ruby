# frozen_string_literal: true

module ApplicationHelper
  def number_to_currency(number, options = {})
    options[:locale] ||= I18n.locale

    number = usd_to_uah(number) if options[:locale] == :uk
    super(number, options)
  end
end
