module UsersHelper
  def joinOrderButton(order)
    if order.admin == @current_user
      "<button 'btn-xs'>#{link_to "You created this order", order_path(order)}</button>".html_safe
    elsif order.users.include?(@current_user)
      "<button 'btn-xs'>#{link_to "You're part of this order", order_path(order)}</button>".html_safe
    else
      "<button 'btn-xs'>#{link_to "Join this order!", order_path(order)}</button>".html_safe
    end
  end
end
