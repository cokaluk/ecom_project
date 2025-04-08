class CartsController < ApplicationController
  before_action :initialize_cart

  def show
    @products = Product.find(@cart)
  end

  def add_item
    product_id = params[:product_id].to_i
    @cart << product_id unless @cart.include?(product_id)
    session[:cart] = @cart
    redirect_to cart_path, notice: "Product added to cart."
  end

  def remove_item
    product_id = params[:product_id].to_i
    @cart.delete(product_id)
    session[:cart] = @cart
    redirect_to cart_path, notice: "Product removed from cart."
  end

  private

  def initialize_cart
    session[:cart] ||= []
    @cart = session[:cart]
  end
end
