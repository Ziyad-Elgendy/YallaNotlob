class Order < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :order_items
end
