class ProductsController < ApplicationController
  def index
  end

  def new
    @product = Product.new
    @user = current_user
  end

  def create
    @product = Product.new(product_params)
    @user = current_user
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def product_params
    params.require(:product).permit(:title, :text, :category_id, :status_id, :ship_pay_id, :area_id, :delivery_day_id, :price, :image).merge(user_id: current_user.id)
  end

end
