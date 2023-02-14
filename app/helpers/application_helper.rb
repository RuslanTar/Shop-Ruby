# frozen_string_literal: true

module ApplicationHelper
  def number_to_currency(number, options = {})
    options[:locale] ||= I18n.locale

    number = usd_to_uah(number) if options[:locale] == :uk
    super(number, options)
  end

  def active_url?(link)
    if request.path == '/'
      return unless link.start_with?("#{request.path}?") || link == request.path

      'active'
    end
    'active' if link.partition('?')[0].in?(request.path)
  end
end
