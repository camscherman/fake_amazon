require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'requires a first name' do
      u = User.new
      u.valid?
      expect(u.errors.messages).to have_key(:first_name)
    end

    it 'requires a last name' do
      u= User.new
      u.valid?
      expect(u.errors.messages).to have_key(:last_name)
    end

    it 'requires a unique email' do
      u = FactoryGirl.create(:user)
      v = User.new(FactoryGirl.attributes_for(:user))
      v.email = u.email
      v.valid?

      expect(v.errors.messages).to have_key(:email)

    end

    it "has a full name method that returns a concatenated string" do
      u = FactoryGirl.create(:user)
      test_name = "#{u.first_name} #{u.last_name}"
      expect(u.full_name).to eq(test_name)
    end

  end
end
