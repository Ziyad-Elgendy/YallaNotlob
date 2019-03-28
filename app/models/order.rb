class Order < ApplicationRecord
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  has_many :user_orders
  has_many :order_items
  has_one_attached :img
  belongs_to :user
  
  def count_invited_users(order)
    UserOrder.where(:order_id => order , :status => 'invited').count
  end
  def count_joined_users(order)
    UserOrder.where(:order_id => order , :status => 'joined').count
  end
end
