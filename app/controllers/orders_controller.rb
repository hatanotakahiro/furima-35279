class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:index, :create]
  before_action :authenticate_buyer_or_sold_out
  before_action :set_order_new, only: [:index , :create]

  def index
  end

  def create
    @order_deliver = OrderDeliver.new(order_deliver_params)
    if @order_deliver.valid?
      pay_product
      @order_deliver.save
      redirect_to root_path
    else
      render :index
    end
  end

  
  private
  def order_deliver_params
    params.require(:order_deliver).permit(:postal_code, :area_id, :city, :number, :building, :phone).merge(token: params[:token], user_id: current_user.id, product_id: @product.id)
  end

  def pay_product
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @product.price,
      card: order_deliver_params[:token],
      currency: 'jpy'
    )
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_order_new
    @order_deliver = OrderDeliver.new
  end

  def authenticate_buyer_or_sold_out
    @product = Product.find(params[:product_id])
    if @product.user == current_user || @product.order.present?
      redirect_to root_path
    end
  end

end