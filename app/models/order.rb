class Order < ApplicationRecord
  has_many :user_orders
  has_many :order_items
end
