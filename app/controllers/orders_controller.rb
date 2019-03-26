class OrdersController < ApplicationController
    def index
    end
    def show
    end
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
end
