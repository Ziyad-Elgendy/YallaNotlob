class OrderItemsController < ApplicationController
    # render :layout => "application"
    def index
        @order_item = OrderItem.where(order_id: params[:order_id])
        @invitation = UserOrder.where(order_id: params[:order_id], status: "invited")
        @joined = UserOrder.where(order_id: params[:order_id], status: "Joined")

    end
    def create
        @order = Order.find(params[:order_id])
        @orderItem = OrderItem.new
        @orderItem.name = params[:name]
        @orderItem.amount = params[:amount]
        @orderItem.price = params[:price]
        @orderItem.comment = params[:comment]
        @orderItem.user = current_user;
        @orderItem.order = @order;
        puts "ORDER======================================\n";
        puts @orderItem;
        puts "======================================\n";
        @orderItem.save
        redirect_to order_order_items_path
      end
  
        def destroy
            @order = Order.find(params[:order_id])
            @order = @order.order_items.find(params[:id])
            @order.destroy
            redirect_to order_order_items_path
        end

end