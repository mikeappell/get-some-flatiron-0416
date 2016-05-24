class ItemsController < ApplicationController
  def create
    @item = Item.new(item_params)
    @item.user = @current_user
    if @item.save
      ActionCable.server.broadcast 'items',
        name: @item.name,
        cost: @item.cost
      head :ok
      # render json: {
      #   item_name: @item.name, 
      #   item_cost: @item.cost
      # }
    else
      error_message = @item.errors.messages
      render partial: 'shared/errors', locals: { errors: flash.now[:alert] = "Item " + error_message[:name][0] }
    end
  end

  private

  def item_params
    params.permit(:order_id, :cost, :name)
  end
end

