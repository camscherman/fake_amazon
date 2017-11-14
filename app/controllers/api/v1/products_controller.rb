class Api::V1::ProductsController < Api::BaseController
    def index
        
        @products = Product.all.order(created_at: :desc)
        
    end

    def show
        @product = Product.find(params[:id])
        
        # @reviews = @product.reviews
        render json: @product
    end

    def create 
        render json: :params
        # @question = Question.new question_params
        # @question.user = User.last
        
        # if @question.save
        #     render json: @question
        # else
        #     render json: { errors: @question.errors.full_messages }
        # end
    end

    private
    def product_params
        
        params.require(:product).permit(:title, :description,:price, :sale_price, {tag_ids: []})
    end

end
