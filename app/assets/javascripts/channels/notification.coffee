App.notification = App.cable.subscriptions.create "NotificationChannel",
  connected: ->
    console.log("Web Socket Client Connected")
  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    console.log(data['message'])

  send_msg: (data) ->
    @perform 'send_msg', message:data