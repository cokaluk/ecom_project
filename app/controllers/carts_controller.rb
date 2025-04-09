class CartsController < ApplicationController
  before_action :initialize_cart

  def show
    @cart = session[:cart]
  end

  def add_item
    logger.debug "Cart before adding: #{session[:cart].inspect}"
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i

    logger.debug "Adding product: #{product.name}, Quantity: #{quantity}"

    existing_product = session[:cart].find { |item| item["id"] == product.id }

    if existing_product
      logger.debug "Product found in cart, updating quantity. current quantity: #{existing_product[:quantity]}"
      existing_product["quantity"] += quantity
    else
      logger.debug "Product not found in cart, adding new product."
      session[:cart] ||= []
      session[:cart] << {"id" => product.id, "name" => product.name, "price" => product.price, "quantity" => quantity }
    end

    redirect_to cart_path
  end

  def remove_item
    product_id = params[:product_id].to_i
    session[:cart].reject! { |product| product["id"] == product_id}
    redirect_to cart_path
  end

  def update_item
    product_id = params[:product_id].to_i
    quantity = params[:quantity].to_i

    product = session[:cart].find { |item| item["id"] == product_id }

    if product
      product["quantity"] = quantity
    end

    redirect_to cart_path
  end

  private

  def initialize_cart
    session[:cart] ||= []
    @cart = session[:cart]
  end
end
