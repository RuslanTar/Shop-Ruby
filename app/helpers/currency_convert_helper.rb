# frozen_string_literal: true

module CurrencyConvertHelper
  def usd_to_uah(amount)
    convert_currency(amount, 'USD', 'UAH')
  end

  def convert_currency(amount, from, to)
    amount * ENV["#{from.upcase}_TO_#{to.upcase}"].to_i
  end
end

