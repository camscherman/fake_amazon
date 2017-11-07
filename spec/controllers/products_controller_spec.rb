require 'rails_helper'
require 'pry'

RSpec.describe ProductsController, type: :controller do


    describe "destroy" do
        
    

        it "destroys a product when you follow the destroy path" do
            product = FactoryGirl.create(:product)
            before_count = Product.count 
            delete :destroy, params:{id: product.id}
            after_count = Product.count 
            
            expect(after_count).to eq(before_count -1 )
        end

        it "redirects user to products path after delete" do
            product = FactoryGirl.create(:product)

            delete :destroy, params: {id: product.id}

            expect(response).to redirect_to(products_path)
        end

    end

    describe "show" do

        it 'renders products#show' do
            product = FactoryGirl.create(:product)

            get :show, params: {id: product.id }

            expect(response).to render_template(:show)
        end
    
    end

end
