class NotificationChannel < ApplicationCable::Channel
  def subscribed
     stream_from current_user.id
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_msg(data)
      msg = data['message'].split(",")
      if msg[1] == "Invitation"
        userId = msg[0]
        invitedUserName = msg[2]
        @orderId = Order.last(1).first.id
        ActionCable.server.broadcast userId, message:data['message']+","+@orderId.to_s
      else 
        @orderId = msg[0]
        @order = Order.find(@orderId)
        @notification = Notification.where(["text like ? and user_id = ? and order_id = ? and typeOfMessage = ? ", current_user.name+"%", @order.user.id ,@order.id ,"Joined"])
        if @notification.count == 0
            ActionCable.server.broadcast @order.user.id, message:data['message']+","+ current_user.name+ "," +@order.name
        end
        puts @notification.count
        puts data['message']+","+ current_user.name+ "," +@order.name
  # //      @orderOwner = @order.user;

# //        ActionCable.server.broadcast userId, message:data['message']+","+@orderId.to_s
      end
  end
end
