# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update]

  def index
    @all_products = Product.all.order(:id)
  end

  def show
    # render status: :unprocessable_entity
    # @product.broadcast_replace_to 'products', partial: 'products/product_modal', locals: { product: @product }, target: "niceModal"


    # respond_to do |format|
    #   # format.turbo_stream
    #   format.html {}
    # end
  end

  # def edit; end

  def create
    @product.create(product_params)
  end

  # def update
    # if @product.update(product_params)
    #   redirect_to product_path(@product)
    # else
    #   render :edit, status: :unprocessable_entity
    # end
  # end

  private

  def product_params
    params.require(:product).permit(:title, :description, images: [])
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
