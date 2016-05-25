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
      deleteButton = button_tag('Delete', :id => "item-delete-#{item.id}", class: 'item-delete')
      "<li class='list-group-item list-group-item-success' id='item-#{item.id}'>#{item.name} - $#{item.cost_formatted} #{deleteButton}</li>".html_safe
    elsif (item.user == @current_user)
      "<li class='list-group-item list-group-item-success' id='item-#{item.id}'>#{item.name} - $#{item.cost_formatted}</li>".html_safe
    else
      "<li class='list-group-item list-group-item-info' id='item-#{item.id}'>#{item.name} - $#{item.cost_formatted} (#{@current_user.username})</li>".html_safe
    end
  end

  def placeOrderButton
    if @order.placed && @order.alerted
      button_tag("You got some ;)", id: "users-alerted", class: "alert alert-success", disabled: true)
    elsif @order.placed
      button_tag("Alert Users to Delivery?", id: "alert-users-btn", class: "alert alert-danger")
    else
      button_tag("Place Order", id: "order-create-btn", class: "alert alert-danger")
    end
  end
end
