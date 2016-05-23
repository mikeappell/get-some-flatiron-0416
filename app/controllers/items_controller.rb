class ItemsController < ApplicationController
  def create
    @item = Item.new(item_params)
    @item.user = @current_user
    if @item.save
      render json: {
        item_name: @item.name, 
        item_cost: @item.cost
      }
    else
      # binding.pry
      flash[:alert] = @item.errors.messages
      render partial: 'shared/errors', locals: { errors: flash[:alert] }
      # Ask if we can render fail from else
    end
  end

  private

  def item_params
    params.permit(:order_id, :cost, :name)
  end
end