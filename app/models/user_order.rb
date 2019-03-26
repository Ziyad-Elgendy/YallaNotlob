class UserOrder < ApplicationRecord
    belongs_to :user
    belongs_to :order
    def count_invited_users(order)
         UserOrder.where(:order_id => order , :status => 'invited').count
    end
    def count_joined_users(order)
        UserOrder.where(:order_id => order , :status => 'joined').count
    end
end
