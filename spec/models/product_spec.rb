require 'rails_helper'

RSpec.describe Product, type: :model do

  describe "validations" do
    def valid_product
      @p = Product.new(FactoryGirl.attributes_for(:product))
    end
     
    it "requires a title" do
      p = Product.new
      p.valid?

      expect(p.errors.messages).to have_key(:title)
    end

    it "requires title to be unique" do
      p = Product.create(title: "Book", description: "Blah blah blah blah blah", price: 5)
      c= Product.new(title: "Book")

      c.valid?

      expect(c.errors.messages).to have_key(:title)
    end

    it "capitalizes title before save" do
      p = Product.new(title: "dog", description: "BABABABABBBBBABAB", price: 100)
      p.save

      expect(p.title).to eq("Dog")
    end

    it "requires a description" do
      p = Product.new(title: "Book")
      p.valid?

      expect(p.errors.messages).to have_key(:description)


    end

    it "requires a price" do
      p = Product.new(title: "Book")
      p.valid?

      expect(p.errors.messages).to have_key(:price)
    end

    it "requires price to be greater than 0" do
      p = Product.new(title: "Book", price: -5 )
      p.valid?
    end

    it "sets sale_price equal to price if not present" do
      p = Product.create(FactoryGirl.attributes_for(:product).merge({sale_price: nil}))

      expect(p.sale_price).to eq(p.price)

      
    end

    it "requires sale_price to be less than price" do
      valid_product
      @p.sale_price = 500
      @p.valid?

      expect(@p.errors.messages).to have_key(:sale_price)
    end

    it "has method 'on_sale' that checks if an item is on sale" do
      valid_product
      expect(@p.on_sale?).to be(true)
    end

  end
  
end
