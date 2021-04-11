class OrdersController < ApplicationController
  before_action :authenticate_user!
  def index
    @order_send = OrderSend.new
    @product = Product.find(params[:product_id])
  end
  def new
    @order_send = OrderSend.new
  end
  def create
    @order_send = OrderSend.new(order_send_params)
    @product = Product.find(params[:product_id])
    if @order_send.valid?
      binding.pry
      pay_product

      @order_send.save
      redirect_to root_path
    else
      @product = Product.find(params[:product_id])
      render :index
    end
  end
  private
  def order_send_params
    params.require(:order_send).permit(:postal_code, :area_id, :city, :number, :building, :phone, :product_id, :token).merge(token: params[:token], user_id: current_user.id, product_id: params[:product_id])
  end

  def pay_product
    Payjp.api_key = "sk_test_c5cdc5e25787e58d060795ad"  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @product.price,  # 商品の値段
      card: order_send_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end