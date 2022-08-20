class Order < ApplicationRecord
  belongs_to :user

  has_many :order_items, dependent: :destroy

  enum status: %i[in_progress ordered canceled]

end
