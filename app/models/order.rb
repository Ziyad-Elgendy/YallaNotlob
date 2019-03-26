class Order < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :order_items
  has_one_attached :img
end
