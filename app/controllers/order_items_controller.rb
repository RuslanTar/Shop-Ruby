# frozen_string_literal: true

class OrderItemsController < ApplicationController
  before_action :set_product

  def create
    if @order_item
      value = params[:method] == 'decrement' ? -1 : 1
      @order_item.update(quantity: @order_item.quantity + value)
    else
      @order_item = current_order.order_items.create(product_id: params[:product_id])
    end

    redirect_to root_path
  end

  def update
    @order_item.update!(quantity: params[:quantity])
    redirect_to orders_path
  end

  def destroy
    @order_item.destroy
    redirect_to orders_path
  end

  private

  def set_product
    @order_item = current_order.order_items.find_by(product: params[:product_id])
  end
end
