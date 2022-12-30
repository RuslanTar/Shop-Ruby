class GetCurrencyService < ApplicationService
  def call
    get_currency
    UpdateCurrenciesJob.perform_at(1.day.from_now)
  end

  private

  def get_currency
    base = 'USD'
    symbols = %w[UAH]

    response = HTTParty.get("https://api.apilayer.com/exchangerates_data/latest?symbols=#{symbols.join(',')}&base=#{base}",
                            headers: {
                              apikey: ENV['CURRENCY_API_KEY']
                            })

    return response['error']['code'] if response['error']

    return unless response['success']

    symbols.each do |currency|
      ENV["#{base}_TO_#{currency}"] = response['rates'][currency].to_s
    end
  end
end
