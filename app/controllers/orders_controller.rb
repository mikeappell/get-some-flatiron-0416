class OrdersController < ApplicationController
  before_action :set_order, only: [:edit, :show, :update, :destroy]

  def new
    @user = current_user
    @order = Order.new
    @organization = Organization.find_by(id: params[:user][:organization_ids])
  end

  def create
    expiration = Time.now + params[:order][:expiration].to_i.minutes
    restaurant = Restaurant.find_or_create_by(name: params[:order][:restaurant])
    @order = Order.new(order_params)
    @order.set_order_params(restaurant, expiration, current_user)
    if @order.save
      redirect_to order_path(@order)
    else
      render 'show', alert: "Please fill in the highlighted field"
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:organization_id, :date_ordered, :admin_id, :description, :minimum_cost)
  end
end
