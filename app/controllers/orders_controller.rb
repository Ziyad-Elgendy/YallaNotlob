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
        if(params[:order])
            @order.img.attach(params[:order][:img])
        end
        @order.status="waiting"
        @order.user=current_user
        if @order.save
            if(!params[:friends_invited].empty?)
                users = JSON.parse params[:friends_invited]
                users.each do |user|
                    @userObj = User.find_by name: user
                    @notification = Notification.new
                    @notification.order=@order
                    @notification.user=@userObj
                    @notification.type="Join"
                    @notification.status="Unread"
                    @notification.text= current_user.name + " invited you to his order"
                    @notification.save
                    @userOrder = UserOrder.new
                    @userOrder.order=@order
                    @userOrder.user=@userObj
                    @userOrder.status="Invited"
                    @userOrder.save
                end
            end
            redirect_to orders_path
        end
        
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
