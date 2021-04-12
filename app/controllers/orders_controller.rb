class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:index, :create]
  before_action :authenticate_buyer
  before_action :sold_out
  before_action :set_order_new, only: [:index ,:new , :create]

  def index
  end

  def new
  end

  def create
    @order_deliver = OrderDeliver.new(order_deliver_params)
    if @order_deliver.valid?
      pay_product
      binding.pry
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
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @product.price,  # 商品の値段
      card: order_deliver_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_order_new
    @order_deliver = OrderDeliver.new
  end

  def authenticate_buyer
    @product = Product.find(params[:product_id])
    if @product.user == current_user
      redirect_to root_path
    end
  end

  def sold_out
    @product = Product.find(params[:product_id])
    if @product.order.present?
      redirect_to root_path
    end
  end

end