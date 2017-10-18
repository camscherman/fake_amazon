class ProductsController < ApplicationController
  
  
  before_action :find_product , only:[:show,  :update, :destroy, :edit]

  before_action :get_categories, only: [:new, :create, :edit, :update]
  before_action :authenticate_user, except: [:index, :show]
  before_action :authorize_user!, except: [:index, :show, :new, :create]

  def index
    @products = Product.all.order(created_at: :desc)
  end
  
  def new
    @product  = Product.new  
  end

  def edit
  end


  def create
    
    @product = Product.new(get_params)
    @product.user = current_user
    if(@product.save)
       redirect_to product_path(@product)
    else
      render new_product_path
    end  
  end

  def update
    if @question.update
      redirect_to @product
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end

  def show
    @review = Review.new
  end



private

  def get_params
    params.require(:product).permit(:title, :description, :price,:category_id)
  end

  def find_product
    @product = Product.find(params[:id])
  end

  def get_categories
    @categories = Category.all
  end

  def authorize_user!
    unless can?(:manage, @product)
      flash[:alert] ="Access denied"
      redirect_to root_path
    end
  end
end
