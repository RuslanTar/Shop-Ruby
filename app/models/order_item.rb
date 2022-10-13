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

  validates :quantity, numericality: { greater_than_or_equal_to: 1 }
end
