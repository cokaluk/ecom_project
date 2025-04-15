class ProductsController < ApplicationController
  def index
    @categories = Category.all
    @products = Product.all

    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end

    if params[:query].present?
      @products = @products.where("name LIKE :q OR description LIKE :q", q: "%#{params[:query]}%")
    end

    @products = @products.page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
  end
end
