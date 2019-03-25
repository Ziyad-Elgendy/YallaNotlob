class GroupsController < ApplicationController

  def index
      @groups = Group.all
      @group = Group.new
  end

  def show
    @groups = Group.all
    @group = Group.new
    @group = Group.find(params[:id])
    @friends = @group_s.users
    render :index
  end 


  def new
    @group = Group.new
  end
  
  def create
    if group_params[:name] == ""
      respond_to do |format|
        format.html { redirect_to groups_path, notice: 'Group was Empty Cant created.' }
      end
			
    else
      if current_user.groups.exists? name: group_params[:name]
				#this group is already exist
        respond_to do |format|
          format.html { redirect_to groups_path, notice: 'Group was Found .' }
        end
      else
        @group = Group.new(group_params.merge(user_id: current_user))
        @group.user_id = current_user.id
        respond_to do |format|
          if @group.save
            format.html { redirect_to groups_path, notice: 'Group was successfully created.' }
            format.json { render :show, status: :created, location: @group }
          else
            format.html { render :index }
            format.json { render json: @group.errors, status: :unprocessable_entity }
          end
        end
      end
    end
  end
      
  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_path, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end	 
  end  
      


  private
  def group_params
    params.require(:group).permit(:name, :user_id)
  end
  

end
