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
        action: "add-item"
      head :ok
    else
      error_message = @item.errors.messages
      render partial: 'shared/errors', locals: { errors: flash.now[:alert] = "Item " + error_message[:name][0] }
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    render json: { id: @item.id }
  end

  private

  def item_params
    params.require(:item).permit(:order_id, :cost, :name)
  end
end

