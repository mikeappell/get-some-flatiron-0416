class GroupsController < ApplicationController

  def new
    @group = Group.new
    @organizations = @current_user.organizations
  end

  def create
    group = Group.create(group_params)
    current_user.groups << group
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

  def organization_groups
    organization = Organization.find(params[:organization_id].to_i)
    session[:current_org] = organization.id
    groups = current_user.groups.select { |group| group.organization == organization }
    org = organization.domain_name
    
    render json: { groups: groups, organization: org }
  end

  private

  def group_params
    params.require(:group).permit(:name, :organization_id)
  end

end
