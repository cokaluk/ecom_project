class ProductsController < ApplicationController
  def index
    @categories = Category.all
    @products = Product.all

    if params[:on_sale].present?
      @products = @products.where(on_sale: true)
    end

    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end

    if params[:new].present?
      @products = @products.where("created_at >= ?", 3.days.ago)
    end

    if params[:query].present?
      @products = @products.where("name LIKE :q OR description LIKE :q", q: "%#{params[:query]}%")
    end

    @products = @products.page(params[:page]).per(12)
  end

  def show
    @product = Product.with_attached_image.find(params[:id])
  end
end
