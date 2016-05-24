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
      #   item_id: @item.id
      # }
    else
      error_message = @item.errors.messages
      render partial: 'shared/errors', locals: { errors: flash.now[:alert] = "Item " + error_message[:name][0] }
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    render json: { destroyed: true }
  end

  private

  def item_params
    params.require(:item).permit(:order_id, :cost, :name)
  end
end

