class Order < ApplicationRecord
  has_many :user_orders 
  has_many :order_items 
  has_one_attached :img
  belongs_to :user
end
