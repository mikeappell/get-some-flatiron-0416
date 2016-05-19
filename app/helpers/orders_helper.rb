module OrdersHelper
  def order_organizations
    if @user.organizations.count == 1
      @user.organizations.first.name
    else
      if @organization
        collection_select(:user, :organization_ids, @user.organizations, :id, :name, {selected: @organization.id})
      else
        collection_select(:user, :organization_ids, @user.organizations, :id, :name, {selected: 0})
      end
    end
  end
end
