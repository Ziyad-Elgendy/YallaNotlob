class GroupsController < ApplicationController

  def index
      @groups = Group.all
      @group = Group.new
      @group_s = Group.find(params[:id])
      @friends = @group_s.users
  end

  def show
    
    @groups = Group.all
    @group = Group.new
    @group = Group.find(params[:id])
    @group_s = Group.find(params[:id])
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
    @user = @group.user_id
    if @user == current_user.id
      @group.destroy
      respond_to do |format|
      format.html { redirect_to groups_path, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
      end
    end
    respond_to do |format|
      format.html { redirect_to groups_path, notice: 'You can\'t delete the group ' }
      format.json { head :no_content }
    end	 
  end  
      

  def addFriend
    #Now i have this friend data from the data base and i already have the groupId
    #get the friend name
		@friendName = params[:name]	
    #check if it is null
  if @friendName.empty?
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, notice: 'Please insert some data !' }
      format.json { head :no_content }
    end
  else
    #check if it is wrong type
    if User.exists? name: @friendName
    #it is really a user
    #check if he is tring to add himself
    if @friendName == current_user.name	
      respond_to do |format|
        format.html { redirect_back fallback_location: root_path, notice: 'Cant inser your self!' }
        format.json { head :no_content }
      end
      else	
    #check if the user exist in the group itself before
      @fid = User.find_by(name: params[:name])
      @current_group = Group.find(params[:groupId])
      if @current_group.group_members.exists? user: @fid.id  	  
        puts "why you are tring to add the same friend"
        respond_to do |format|
          format.html { redirect_back fallback_location: root_path, notice: 'This Friend is already assigned to this group !!' }
          format.json { head :no_content }
        end
      else
        #check if this user in friendship list or not
        @fid = User.find_by(name: params[:name])
        @user = current_user
        if @user.user_friends.exists? friend: @fid.id
        @fid = User.find_by(name: params[:name])
        @gid = params[:groupId]
        @group = @fid.group_members.create(group_id: @gid)
            respond_to do |format|
              format.html { redirect_back fallback_location: root_path, notice: 'This Friend is Add !!' }
              format.json { head :no_content }
            end
          else
            respond_to do |format|
              format.html { redirect_back fallback_location: root_path, notice: 'This user is not currently in your friend list! !!' }
              format.json { head :no_content }
            end
          	
          end
      end					
      
    
    end	
    else
    #it is a robot
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, notice: 'This user is not exist !' }
      format.json { head :no_content }

    end	
  end
  end		

  end




  private
  def group_params
    params.require(:group).permit(:name, :user_id)
  end
  

end
