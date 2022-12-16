# frozen_string_literal: true

# == Schema Information
#
# Table name: order_items
#
#  id         :bigint           not null, primary key
#  quantity   :integer          default(1), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :integer
#  product_id :integer
#
class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :quantity, numericality: { greater_than: 0 }

  def total_price
    quantity * product.price
  end

  # broadcasts_to :order, inserts_by: :prepend
  # after_create_commit do
  #   broadcast_prepend_later_to [order, "order_items"]
  #   broadcast_update_later_to "total_order_#{order.id}", partial: "orders/total", target: "total_order_#{order.id}", locals: { order_total: order.total_price }
  #   broadcast_update_later_to "size_order_#{order.id}", partial: "orders/size", target: "size_order_#{order.id}", locals: { order_size: order.order_items.sum(&:quantity) }
  # end
  # after_update_commit do
  #   broadcast_replace_to "price_order_item_#{self.id}", partial: 'order_items/order_item_quantity_and_price', locals: { order_item: self }, target: "price_order_item_#{self.id}"
  #   broadcast_update_later_to "total_order_#{order.id}", partial: "orders/total", target: "total_order_#{order.id}", locals: { order_total: order.total_price }
  #   broadcast_update_later_to "size_order_#{order.id}", partial: "orders/size", target: "size_order_#{order.id}", locals: { order_size: order.order_items.sum(&:quantity) }
  # end
  # after_destroy_commit do
  #   broadcast_remove_to [order, "order_items"]
  #   broadcast_update_to "total_order_#{order.id}", partial: "orders/total", target: "total_order_#{order.id}", locals: { order_total: order.total_price }
  #   broadcast_update_to "size_order_#{order.id}", partial: "orders/size", target: "size_order_#{order.id}", locals: { order_size: order.order_items.sum(&:quantity) }
  # end
end
