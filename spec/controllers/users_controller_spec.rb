require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:user) {FactoryGirl.create(:user)}

  describe "#new" do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'assigns an new variable @user' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end


  end

  describe '#create' do
    context "with valid sign up" do
        def valid_request
          post :create, params: { user: FactoryGirl.attributes_for(:user)}
        end
        it 'creates a new user in the database' do
          users_before = User.count
          valid_request

          users_after = User.count
          expect(users_before).to eq(users_after -1)
        end

        it "signs the user in" do
      # session[:user_id] = nil

        valid_request
        expect(session[:user_id]).to be
      end

      it "redirects users to home on successful request" do
        valid_request
        expect(response).to redirect_to(root_path)
      end
    end
  context "with invalid parameters" do
    it "doesn't create a user in the database" do
      count_before = User.count
      u = User.create
      count_after = User.count
      expect(count_after).to eq(count_before)
    end

    it "renders the new template" do
      u = FactoryGirl.attributes_for(:user)
      u[:first_name] = nil

      post :create, params: {user: u }
      expect(response).to render_template(:new)
    end
  end



  end

end
