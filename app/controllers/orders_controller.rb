class OrdersController < ApplicationController
  before_action :set_order, only: [:edit, :show, :update, :destroy]

  def new
    @order = Order.new
    @organization = Organization.find_by(id: params[:user][:organization_ids])
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:organization_id, :date_ordered, :expiration, :admin_id, :restaurant_id, :description, :minimum_cost)
  end
end
