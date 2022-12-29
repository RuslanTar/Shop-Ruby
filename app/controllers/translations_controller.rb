class TranslationsController < ApplicationController
  def switch_locale
    redirect_to product_path
  end
end
