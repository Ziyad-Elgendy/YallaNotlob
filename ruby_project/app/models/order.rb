class Order < ApplicationRecord
  belongs_to :user
  belongs_to :order_items
  has_many :users
  has_many :order_items
end
