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
require 'test_helper'

class OrderItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
