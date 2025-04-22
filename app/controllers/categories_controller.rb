class CategoriesController < ApplicationController
  def show
    @categories = Category.all
    @category = Category.find(params[:id])
    @products = @category.products.page(params[:page]).per(12)
  end
end
