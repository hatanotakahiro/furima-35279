class OrdersController < ApplicationController
  before_action :authenticate_user!
  def index
    @order = Order.new(order_params)
    @product = @order.product
  end
  def new
  end
  def create
  end
  private
  def order_params
    # form_withでmodel指定してないのでrequire(:order)要らない
    params.permit().merge(user_id: current_user.id, product_id: params[:product_id])
  end
end
