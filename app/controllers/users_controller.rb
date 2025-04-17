class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = current_user
    @orders = @user.orders.includes(:order_taxes, order_items: :product)
  end
end
