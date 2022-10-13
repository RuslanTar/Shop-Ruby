# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id         :bigint           not null, primary key
#  comments   :string
#  name       :string
#  price      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_products_on_user_id  (user_id)
#
class Product < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
end
