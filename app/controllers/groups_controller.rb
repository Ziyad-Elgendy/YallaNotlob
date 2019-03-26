class GroupsController < ApplicationController


    def index
        @groups = Group.all
        @group = Group.new
      end
      
      def show
          @groups = Group.all
      end    

      def listG
        @groups = Group.where(user_id: current_user.id)
        render :json => @groups
      end

      def listGF
        @group = Group.where(name: params[:name]).first
        @groups = Member.where(group_id: @group.id)
        render :json => @groups, :include => :user
      end
  
      # def new
      #   @group = Group.new
      # end  
          def create
              @group = Group.new(group_params)
              if @group.save
              redirect_to @group
            else
              render 'show'
            end
          end
      
        def delete
  
        end  
      
        def destroy  
            @group = Group.find(params[:id])
            @group.destroy	 
            redirect_to show_path
        end    
  
        private
        def group_params
            params.require(:group).permit(:name)
        end
  
  


end
