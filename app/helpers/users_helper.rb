module UsersHelper
  def joinOrderButton(order)
    if order.admin == @current_user
      "<div class='list-group-item list-group-item-warning' style='margin-top:10px; margin-bottom:5px;'>#{link_to "You created this order", order_path(order)}</div>".html_safe
      # "<button 'btn-xs'>#{link_to "You created this order", order_path(order)}</button>".html_safe
    elsif order.users.include?(@current_user)
      "<div class='list-group-item list-group-item-success' style='margin-top:10px; margin-bottom:5px;'>#{link_to "You're part of this order", order_path(order)}</div>".html_safe
      # "<button 'btn-xs'>#{link_to "You're part of this order", order_path(order)}</button>".html_safe
    else
      "<div class='list-group-item list-group-item-info' style='margin-top:10px; margin-bottom:5px;'>#{link_to "Join this order!", order_path(order)}</div>".html_safe
      # "<button 'btn-xs'>#{link_to "Join this order!", order_path(order)}</button>".html_safe
    end
  end

  def user_select_logic
    if session[:current_org].nil?
      org_collection = @current_user.groups.select { |group| group.organization == Organization.first }
      collection_select(:user, :group_ids, org_collection, :id, :name, {include_blank: "All Groups", selected: 0 })
    else
      organization = Organization.find(session[:current_org].to_i)
      org_collection = @current_user.groups.select { |group| group.organization == organization }
      collection_select(:user, :group_ids, org_collection, :id, :name, {include_blank: "All Groups", selected: 0 })
    end
  end
end
