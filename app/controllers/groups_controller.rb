class GroupsController < ApplicationController

  def index
      @groups = Group.where(user_id: current_user.id)
      @group = Group.new
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

  def show
    @groups = Group.where(user_id: current_user.id)
    @group = Group.new   
    @group = Group.find(params[:id])
    $search = @group.id
    @group_s = Group.find(params[:id])
    @members = Member.where(group_id: params[:id])
    @friends = @group_s.users
    render :index
  end 

  def new
    @group = Group.new
  end

  def create
    if group_params[:name] == ""
      respond_to do |format|
        format.html { redirect_to groups_path, notice: 'Insert the name of the group.' }
      end
    else
      if current_user.groups.exists? name: group_params[:name]
        respond_to do |format|
          format.html { redirect_to groups_path, notice: 'Group already exist .' }
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
      
  def update
    @group = Group.find(params[:id])
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end 

  def destroy
    @group = Group.find(params[:id])
    @user = @group.user_id
    if @user == current_user.id 
      if @group.destroy
        goto_groups_page
      else
        respond_to do |format|
          format.html { redirect_to groups_path, notice: 'You cannot delete this group ' }
          format.json { head :no_content }
        end
      end
    end 
  end

  def goto_groups_page
    respond_to do |format|
      format.html { redirect_to groups_path, notice: 'Group was successfully deleted.' }
      format.json { head :no_content }
    end
  end      

  def addFriend
		@friendName = params[:name]	
    if @friendName.empty?
      respond_to do |format|
        format.html { redirect_back fallback_location: root_path, notice: 'Please insert the name of your friend !' }
        format.json { head :no_content }
      end
    else
      if User.exists? name: @friendNames
        if @friendName == current_user.name	
          respond_to do |format|
            format.html { redirect_back fallback_location: root_path, notice: 'You cannot add yourself !' }
            format.json { head :no_content }
          end
        else	
          @fid = User.find_by(name: params[:name])
          @current_group = Group.find(params[:groupId])
          if @current_group.members.exists? user: @fid.id  	  
            respond_to do |format|
              format.html { redirect_back fallback_location: root_path, notice: 'This Friend is already member of this group !' }
              format.json { head :no_content }
            end
          else
            @fid = User.find_by(name: params[:name])
            @user = current_user
            if @user.friends.exists? friend: @fid.id
            @fid = User.find_by(name: params[:name])
            @gid = params[:groupId]
            @group = @fid.members.create(group_id: @gid)
                respond_to do |format|
                  format.html { redirect_back fallback_location: root_path, notice: 'Friend is add successfully !' }
                  format.json { head :no_content }
                end
            else
              respond_to do |format|
                format.html { redirect_back fallback_location: root_path, notice: 'This user is not one of your friends !' }
                format.json { head :no_content }
              end               
            end
          end					    
        end	
      else
        respond_to do |format|
          format.html { redirect_back fallback_location: root_path, notice: 'This user is not exist !' }
          format.json { head :no_content }
        end	
      end
    end		
  end

  def deletefriend
    @group_member = Member.find_by(group_id: params[:group_id], user_id: params[:user_id])
    if @group_member.destroy
      respond_to do |format|
        format.html { redirect_back fallback_location: root_path, notice: "Freind was successfully deleted." }
        format.json { head :no_content }
      end
    end
  end

  private
  def group_params
    params.require(:group).permit(:name, :user_id)
  end
  
end 