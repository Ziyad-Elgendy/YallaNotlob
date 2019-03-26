class OrdersController < ApplicationController
    def new
        @order =Order.new
    end
    def create
        # puts params[:name]
        # puts params[:restaurant]
        # #puts params[friends_invited:[]]
        # params[:friends_invited].each do |title|
        #     puts title,12
        #   end
        #puts params[:friends_invited]
        # order_params
        @order = Order.new
        @order.name=params[:name]
        @order.restaurant=params[:restaurant]
        p "=============================="
        @order.img.attach(params[:order][:img])
        @order.status="waiting"
        if @order.save
            redirect_to orders_path
        end
        users = JSON.parse params[:friends_invited]
        # users.each do |user|
        #     userObj = User.find_by name: params[:name]
        #      @order = Order.new
        #      @order.user=userObj
        #    end
    end 
    def order_params
        params.permit(:name,:restaurant,:img)
    end
    before_action :authenticate_user!
    layout 'application'
    def index
        @orders = current_user.user_orders.where(:status => 'owner')
    end
    
    def show
    end
    
    def edit
    end
    
    def update
        @order = Order.find(params[:id])
   
      if @order.update(:status => 'finished')
        redirect_to orders_path
      else
        render "index"
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
