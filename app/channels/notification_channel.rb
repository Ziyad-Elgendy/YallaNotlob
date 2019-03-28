class NotificationChannel < ApplicationCable::Channel
  def subscribed
     stream_from current_user.id
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_msg(data)
      ActionCable.server.broadcast "1", message:data['message']
  end
end
