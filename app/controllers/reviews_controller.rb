class ReviewsController < ApplicationController
    before_action :find_product, only:[:create]
    before_action :find_review, only: [:destroy]
    before_action :authenticate_user
    before_action :authorize_user!, only: [:destroy]
    
    def create 
        @review = @product.reviews.build(review_params)
        @review.user = current_user
        if @review.save
            redirect_to product_path(@product)
        else
            @reviews = @product.reviews.order(created_at: :desc)
            render 'products/show'
        end
    end

    def destroy
        @review.destroy
        redirect_to product_path(@review.product)

    end


    private
    def review_params 
        params.require(:review).permit(:body, :rating, :product_id)
    end
    def find_product
        @product = Product.find(params[:product_id])
    end

    def find_review 
        @review = Review.find(params[:id])
    end

    def authorize_user!
        unless can?(:manage, @review)
        flash[:alert] = "Access denied"
        redirect_to root_path
        end
    end 
end
