class ItemsController < ApplicationController
  def create
    @item = Item.new(item_params)
    @item.user = @current_user
    if @item.save
      ActionCable.server.broadcast 'items',
        name: @item.name,
        cost: @item.cost_formatted,
        id: @item.id,
        owner: current_user.id,
        element: "div#item-list",
        action: "add-item",
        username: current_user.username,
        cost_remaining: @item.order.cost_remaining.to_f,
        item_total: @item.order.item_total_formatted
      head :ok
    else
      error_message = @item.errors.messages
      render partial: 'shared/errors', locals: { errors: flash.now[:alert] = "Item " + error_message[:name][0] }
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    ActionCable.server.broadcast 'items',
      name: @item.name,
      id: @item.id,
      cost: @item.cost_formatted,
      action: "delete-item",
      cost_remaining: @item.order.cost_remaining.to_f,
      item_total: @item.order.item_total_formatted
    head :ok
    # render json: { id: @item.id }
  end

  private

  def item_params
    params.require(:item).permit(:order_id, :cost, :name)
  end
end