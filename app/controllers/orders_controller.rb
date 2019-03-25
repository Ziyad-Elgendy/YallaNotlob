class OrdersController < ApplicationController
    before_action :authenticate_user!
    layout 'application'
    def index
        @orders = current_user.user_orders.where(:status => 'owner')
    end
    
    def show
    end
    
    def new
    end
    
    def edit
    end
    
    def create

    end
    
    def update
        @order = Order.find(params[:id])
   
      if @order.update(:status => 'finished')
        redirect_to orders_path
      else
        render 'please try again'
      end
    end
    
    def destroy
        UserOrder.where(:order_id => params[:id]).destroy_all
        OrderItem.where(:order_id => params[:id]).destroy_all
        @order = Order.find(params[:id])
        @order.destroy
     
        redirect_to orders_path
     
    end
    
     
end
