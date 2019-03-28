class WelcomeController < ApplicationController
  # 
  
  
  def index
    @activities = PublicActivity::Activity.where(:owner_id => [current_user.friends.ids])
    @latesOrders = Order.where(:user_id => current_user.id).last(4)
    return @activities, @latesOrders
  end
end
