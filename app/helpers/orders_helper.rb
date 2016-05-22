module OrdersHelper
  def order_organizations(f)
    # if @user.organizations.count == 1
    if @current_user.organizations.count == 1
      "#{f.hidden_field(:organization_id, value: @current_user.organizations.first.id)} #{@current_user.organizations.first.name}".html_safe
      # "#{f.hidden_field(:organization_id, value: @user.organizations.first.id)} #{@user.organizations.first.name}".html_safe
    else
      if @organization
        f.collection_select(:organization_id, @current_user.organizations, :id, :name, {selected: @organization.id})
      else
        f.collection_select(:organization_id, @current_user.organizations, :id, :name, {selected: 0})
      end
      # if @organization
      #   f.collection_select(:organization_id, @user.organizations, :id, :name, {selected: @organization.id})
      # else
      #   f.collection_select(:organization_id, @user.organizations, :id, :name, {selected: 0})
      # end
    end
  end
end
