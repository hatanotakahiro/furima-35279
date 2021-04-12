class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :product_edit_protect, only: [:edit, :update, :destroy]
  before_action :sold_out, only: [:edit, :update]

  def index
    @products = Product.includes(:user).order("created_at DESC")
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product.id)
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to root_path
  end

  private
  def product_params
    params.require(:product).permit(:title, :text, :category_id, :status_id, :ship_pay_id, :area_id, :delivery_day_id, :price, :image).merge(user_id: current_user.id)
  end

  def set_product
    @product = Product.find(params[:id])
  end
  
  def product_edit_protect
    unless @product.user == current_user
      redirect_to action: :index
    end
  end

  def sold_out
    @product = Product.find(params[:id])
    if @product.order.present?
      redirect_to root_path
    end
  end

end
