class GroupsController < ApplicationController

  def new
    @group = Group.new
    @organizations = @current_user.organizations
  end

  def create
    Group.create(group_params)
    redirect_to user_path(@current_user)
  end


  private

  def group_params
    params.require(:group).permit(:name, :organization_id)
  end

end
