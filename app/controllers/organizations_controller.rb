class OrganizationsController < ApplicationController
  before_action :set_user

  def show
  end

  def index
  end

  def new
  end

  def edit
  end

  def manage_organizations
    @user_organizations = current_user.organizations
    @domains = @user_organizations.map {|organization| organization.domain_name}
  end

  def find_org_names
    domain = params[:domain]
    org = Organization.where(domain_name: domain)
    unless org.nil?
      send_back = {}
      org.each do |organization|
        send_back[organization.id] = "#{organization.name} (#{organization.users.count} members)"
      end
    else
      send_back = false
    end

    render json: {
      organizations: send_back
    }
  end

  def set_user
    @current_user = current_user
  end
end
