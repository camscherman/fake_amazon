class FavouritesController < ApplicationController

  def create
    @product = Product.find(params[:product_id])
    favourite = Favourite.new(user: current_user, product: @product)
    if favourite.save
      redirect_to products_path(@product), notice: "#{@product.title} added to favourites."
    else
      redirect_to products_path(@product), notice: "Failed"
    end
  end

  def destroy
    @favourite = Favourite.find_by_id(params[:id])
    @favourite.destroy
    redirect_to products_path
  end

  def index
    @user = current_user
    @favourite_products = @user.favourite_products
  end
end
