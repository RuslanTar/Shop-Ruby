# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id          :bigint           not null, primary key
#  order_items :string
#  status      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#
class Order < ApplicationRecord
  belongs_to :user

  has_many :order_items, dependent: :destroy

  enum status: %i[in_progress ordered canceled], _prefix: true

  def total_price
    order_items.sum(&:total_price)
  end
end
