class GroupsController < ApplicationController


    def index
        @groups = Group.all
        @group = Group.new
      end
      
      def show
        @groups = Group.all
        @group = Group.new
        @group = Group.find(params[:id])
      end    

  
      # def new
      #   @group = Group.new
      # end  
          def create
              @group = Group.new(group_params)
              if @group.save
              redirect_to  groups_path 
            else
              render 'show'
            end
          end
      
        def destroy
          @group = Group.find(params[:id])
          @group.destroy	 
          redirect_to groups_path
        end  
      

        # def destroy  
        #   @group = Group.find(params[:id])
        #   @group.destroy	 
        #   redirect_to root_path
        # end    
  
        private
        def group_params
          params.require(:group).permit(:name)
        end
  
  


end
