class OrganizationsController < ApplicationController

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
    @current_org = Organization.find_by(id: session[:current_org].to_i) || current_user.organizations.first
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

end
