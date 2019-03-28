class OrderItemsController < ApplicationController
    # render :layout => "application"
    def index
        if params['join'] == "true"
            @user_order = UserOrder.where({order_id: params[:order_id],user_id: current_user.id}).first
            if @user_order != nil
                if @user_order.status != "Joined"
                    @user_order.update(status: "Joined")
                    @notification  = Notification.new
                    @notification.order=@user_order.order
                    @notification.user=@user_order.order.user
                    @notification.typeOfMessage="Joined"
                    @notification.status="Unread"
                    @notification.text= current_user.name + " Joined your " + @user_order.order.name.to_s
                    @notification.save
                end
            end
        end
        @order_item = OrderItem.where(order_id: params[:order_id])
        @order =  Order.find(params[:order_id])
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
        puts @orderItem;
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
