class ReviewsMailer < ApplicationMailer
  def notify_review_product_owner(review)
    @review = review
    @product = @review.product
    @product_owner = @product.user
    mail(to:'camscherman@hotmail.com', subject: "New review on #{@product.title}")
  end
end
