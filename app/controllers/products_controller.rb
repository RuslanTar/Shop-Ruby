# frozen_string_literal: true

class ProductsController < ApplicationController
  # include ActiveModel::Model
  # include ProductSearchable

  before_action :set_product, only: %i[show update destroy]

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
    @product.update(product_params)
  end

  def destroy
    flash[:error] = @product.errors.full_messages unless @product.destroy
  end

  def search
    @products = Product.search(params[:query]) if params[:query].present?
  end

  def filter
    @results = Product.filter(params[:price_min], params[:price_max], params[:sort_by])
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, images: [])
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
