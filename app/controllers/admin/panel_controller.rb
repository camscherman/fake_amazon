class Admin::PanelController < ApplicationController

    def index
        @stats = {
            user_count: User.count,
            product_count:Product.count,
            review_count: Review.count
        }
        @users = User.all
    end
end
