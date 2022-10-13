# frozen_string_literal: true

class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.integer :product_id
      t.integer :quantity, null: false, default: 1
      t.integer :order_id

      t.timestamps
    end
  end
end
