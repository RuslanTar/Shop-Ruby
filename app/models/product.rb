# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  comments    :string
#  description :text
#  name        :string
#  price       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#
# Indexes
#
#  index_products_on_user_id  (user_id)
#
class Product < ApplicationRecord
  belongs_to :user

  # attribute :images, default: ['everlabs_logo.jpeg']

  validates :name, presence: true
  validates :images, file_size: { less_than_or_equal_to: 10.megabytes, message: 'Please Check File Size' },
                     file_content_type: { allow: %w[image/jpeg image/jpg image/png image/gif],
                                          message: 'Please Check File Format' }

  has_many_attached :images do |attachable|
    attachable.variant :small, resize_to_limit: [100, 100]
    attachable.variant :medium, resize_to_limit: [300, nil]
    attachable.variant :large, resize_to_limit: [500, 500]
  end
end
