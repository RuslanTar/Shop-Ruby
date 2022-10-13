# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @all_products = Product.all
  end

  def show
    @product = Product.find_by(id: params[:product_id])
  end

  def create
    @product.create(permitted_parameters)
  end

  def permitted_parameters
    params.permit(:name, :price)
  end
end
