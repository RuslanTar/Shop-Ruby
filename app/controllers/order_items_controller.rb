# frozen_string_literal: true

class OrderItemsController < ApplicationController
  before_action :set_order_item

  def create
    if @order_item
      @order_item.update(quantity: @order_item.quantity + 1)
    else
      @order_item = current_order.order_items.create(product_id: params[:product_id])
    end

    @order_item.broadcast_prepend_later_to [@order_item.order, 'order_items']
    @order_item.broadcast_update_later_to "total_order_#{@order_item.order.id}",
                                          partial: 'orders/total',
                                          target: "total_order_#{@order_item.order.id}",
                                          locals: { order_total: @order_item.order.total_price }
    @order_item.broadcast_update_later_to "size_order_#{@order_item.order.id}",
                                          partial: 'orders/size',
                                          target: "size_order_#{@order_item.order.id}",
                                          locals: { order_size: @order_item.order.order_items.sum(&:quantity) }

    # respond_to do |format|
    #   format.turbo_stream
    # end
  end

  def update
    @order_item.update!(quantity: params[:quantity])

    @order_item.broadcast_replace_later_to "price_order_item_#{@order_item.id}",
                                           partial: 'order_items/order_item_quantity_and_price',
                                           target: "price_order_item_#{@order_item.id}",
                                           locals: { order_item: @order_item }
    @order_item.broadcast_update_later_to "total_order_#{@order_item.order.id}",
                                          partial: 'orders/total',
                                          target: "total_order_#{@order_item.order.id}",
                                          locals: { order_total: @order_item.order.total_price }
    @order_item.broadcast_update_later_to "size_order_#{@order_item.order.id}",
                                          partial: 'orders/size',
                                          target: "size_order_#{@order_item.order.id}",
                                          locals: { order_size: @order_item.order.order_items.sum(&:quantity) }

    # respond_to do |format|
    #   format.turbo_stream
    # end
  end

  def destroy
    @order_item.destroy

    @order_item.broadcast_remove_to [@order_item.order, 'order_items']
    @order_item.broadcast_update_to "total_order_#{@order_item.order.id}",
                                    partial: 'orders/total',
                                    target: "total_order_#{@order_item.order.id}",
                                    locals: { order_total: @order_item.order.total_price }
    @order_item.broadcast_update_to "size_order_#{@order_item.order.id}",
                                    partial: 'orders/size',
                                    target: "size_order_#{@order_item.order.id}",
                                    locals: { order_size: @order_item.order.order_items.sum(&:quantity) }

    # respond_to do |format|
    #   format.turbo_stream
    # end
  end

  private

  def set_order_item
    # TODO: includes
    @order_item = current_order.order_items.find_by(product: params[:product_id])
  end
end
