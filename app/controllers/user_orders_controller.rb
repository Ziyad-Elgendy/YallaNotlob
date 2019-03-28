class UserOrdersController < ApplicationController
    def destroy
        @order = Order.find(params[:order_id])
        @order = @order.user_orders.find(params[:id])
        @order.destroy
        redirect_to order_order_items_path
    end

end
