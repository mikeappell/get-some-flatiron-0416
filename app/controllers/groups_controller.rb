class GroupsController < ApplicationController

  def new
    @group = Group.new
    @organizations = @current_user.organizations
  end

  def create
    Group.create(group_params)
    redirect_to user_path(@current_user)
  end

  def update
  end

  def handle_toggle
    group = Group.find(params[:id])
    if params[:member] == "true"
      @current_user.groups << group
    else
      @current_user.groups.delete(group)
      @current_user.save
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :organization_id)
  end

end
