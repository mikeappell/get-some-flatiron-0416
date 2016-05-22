module OrdersHelper
  def order_organizations(f)
    if @user.organizations.count == 1
      "#{f.hidden_field(:organization_id, value: @user.organizations.first.id)} #{@user.organizations.first.domain_name}".html_safe
    else
      if @organization
        f.collection_select(:organization_id, @user.organizations, :id, :name, {selected: @organization.id})
      else
        f.collection_select(:organization_id, @user.organizations, :id, :name, {selected: 0})
      end
    end
  end
end
