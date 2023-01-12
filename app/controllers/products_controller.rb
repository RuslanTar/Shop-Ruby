# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

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

  def new; end

  def create
    @product = Product.create(product_params)
    # render 'admin/products/new', status: :unprocessable_entity
    # render @product.errors.full_messages unless @product.valid?
    # flash[:error] = @product.errors.full_messages unless @product.save!
  end

  def update
    if @product.update(product_params)
      # redirect_to product_path(@product)
      head :ok
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    flash[:error] = @product.errors.full_messages unless @product.destroy
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, images: [])
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
