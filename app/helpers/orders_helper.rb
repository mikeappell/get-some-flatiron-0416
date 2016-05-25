module OrdersHelper
  def order_organizations(f)
    if @current_user.organizations.count == 1
      "#{f.hidden_field(:organization_id, value: @current_user.organizations.first.id)} #{@current_user.organizations.first.domain_name}".html_safe
    else
      if @organization
        f.collection_select(:organization_id, @current_user.organizations, :id, :domain_name, {selected: @organization.id})
      else
        f.collection_select(:organization_id, @current_user.organizations, :id, :domain_name, {selected: 0})
      end
    end
  end

  def isUserItemOwner(item)
    if (item.user == @current_user) && !@order.expired?
      deleteButton = button_tag('Delete', :id => "item-delete-#{item.id}", class: 'item-delete btn btn-default', style: "float:right; transform: translateY(-15%);")
      "<p class='list-group-item list-group-item-success' id='item-#{item.id}'>#{item.name} - $#{item.cost_formatted} #{deleteButton}</p>".html_safe
    elsif (item.user == @current_user)
      "<p class='list-group-item list-group-item-success' id='item-#{item.id}'>#{item.name} - $#{item.cost_formatted}</p>".html_safe
    else
      "<p class='list-group-item list-group-item-info' id='item-#{item.id}'>#{item.name} - $#{item.cost_formatted} (#{@current_user.username})</p>".html_safe
    end
  end

  def placeOrderButton
    if @order.placed
      button_tag("Alert Users to Delivery?", id: "alert-users-btn", class: "alert alert-danger", data: { confirm: "Are you sure?" })
    else
      button_tag("Place Order", id: "order-create-btn", class: "alert alert-danger")
    end
  end
end
