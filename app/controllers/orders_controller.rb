class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:index, :create]

  def index
    @order_deliver = OrderDliver.new
  end
  def new
    @order_deliver = OrderDliver.new
  end
  def create
    @order_deliver = OrderDliver.new(order_deliver_params)
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
    Payjp.api_key = "sk_test_c5cdc5e25787e58d060795ad"  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @product.price,  # 商品の値段
      card: order_deliver_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end

  def set_product
    @product = Product.find(params[:product_id])
  end
end