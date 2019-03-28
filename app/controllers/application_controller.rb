class ApplicationController < ActionController::Base
    include PublicActivity::StoreController
    before_action :authenticate_user! 
    before_action :configure_permitted_parameters , if: :devise_controller? 
    before_action :get_notification
    layout 'application'

    def get_notification
        if user_signed_in? 
              @notifications = Notification.where(user_id: current_user.id ,status: "Unread")
        end
    end

    protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation)}
    end    

end
