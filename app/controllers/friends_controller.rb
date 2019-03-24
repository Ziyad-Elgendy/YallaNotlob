class FriendsController < ApplicationController
    before_action :authenticate_user!
    layout 'application'

    def create
        user = User.find_by email: params[:email]

        if Friend.create(friend_id: user.id, user_id: current_user.id)
          flash[:notice] = "Added friend."
          redirect_to friends_path
        else
          flash[:error] = "Unable to add friend."
          redirect_to friends_path
        end
      end
      
      def destroy
        @friend = current_user.friends.find(params[:id])
        @friend.destroy
        flash[:notice] = "Removed friend."
        redirect_to friends_path
    end
    def index

        @friends = current_user.friends
      end

end
