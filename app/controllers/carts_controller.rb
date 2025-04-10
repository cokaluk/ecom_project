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

  def checkout
    if user_signed_in?
      user = current_user
      order = Order.create!(
        user_id: user.id,
        status: "new",
        sub_total: calculate_sub_total,
        grand_total: calculate_grand_total
      )

      session[:cart].each do |product|
        OrderItem.create!(
          order_id: order.id,
          product_id: product["id"],
          quantity: product["quantity"],
          unit_price: product["price"]
        )
      end

      user_province = user.province
      taxes = Tax.where(province_id: user_province.id)
      taxes.each do |tax|
        OrderTax.create!(
          order_id: order.id,
          tax_name: tax.tax_type,
          tax_rate: tax.tax_rate
        )
      end

      session[:cart] = []

      redirect_to order_path(order), notice: "your order has been placed successfully!"

    else
      redirect_to new_user_session_path, alert: "You need to sign in to checkout."
    end
  end

  private

  def initialize_cart
    session[:cart] ||= []
    @cart = session[:cart]
  end

  def calculate_sub_total
    session[:cart].sum { |product| product["price"] * product["quantity"] }
  end

  def calculate_grand_total
    sub_total = calculate_sub_total
    # todo calculate tax
    sub_total
  end
end
