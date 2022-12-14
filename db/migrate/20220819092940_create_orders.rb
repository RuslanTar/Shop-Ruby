# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :order_items
      t.string :status
      t.integer :user_id

      t.timestamps
    end
  end
end
