class ProductMailer < ApplicationMailer
  def notify_product_owner(product)
    @product = product
    @product_owner = @product.user
    mail(to: 'camscherman@hotmail.com', subject: 'You made a new product!')
  end
end
