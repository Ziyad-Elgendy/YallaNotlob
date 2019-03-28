class NotificationsController < ApplicationController
    def index
        @allnotifications = Notification.where(user_id: current_user.id)
    end

    def makeAllRead
        Notification.where('user_id = ?', current_user.id).update_all(status: 'Read')
    end
end
