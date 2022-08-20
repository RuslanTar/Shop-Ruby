class OrdersController < ApplicationController

  def index
    @order_items = current_order.order_items
  end

end
