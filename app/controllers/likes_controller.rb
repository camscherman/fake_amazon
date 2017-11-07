class LikesController < ApplicationController

  def create

    review = Review.find(params[:review_id])
    like = Like.new(user: current_user, review: review)
    product = review.product
    if like.save
      redirect_to review.product, notice: "Liked"
    else
      redirect_to review.product, notice: "Not liked"
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @product =@like.review.product
    @like.destroy
    redirect_to @product , notice: 'Like removed'
  end

end
