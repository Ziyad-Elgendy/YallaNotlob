class OrderItemsController < ApplicationController
    # render :layout => "application"
   
    def index
        @order_item = OrderItem.where(order_id: params[:order_id])
        # params[:order_id]
        # puts "==============================="
        # puts params[:order_id]
        # puts @order_item
        # puts "==============================="
    end
    def create
        user = User.find_by email: params[:email]
        if (Order.where(:user_id => current_user.id).count > 0) 
          flash[:error] = "Unable to add order."
            redirect_to orders_path
        else
          if Order.create(user_id: current_user.id)
            flash[:notice] = "Added order."
            redirect_to orders_path
          else
            flash[:error] = "Unable to add order."
            redirect_to orders_path
          end
        end
      end
    def destroy
    end
end
