require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'saves succesfully if all fields are valid' do
      @category = Category.create(id: 1, name: "Cardboard")
      @product = Product.create(id: 1, name: "Box", price_cents: 10000, quantity: 10, category_id: 1)

      expect(@product.save).to be true
    end

    it "has 'Name can't be blank' error when name is nil" do
      @category = Category.create(id: 1, name: "Cardboard")
      @product = Product.create(id: 1, name: nil, price_cents: 10000, quantity: 10, category_id: 1)

      expect(@product.errors.full_messages.include?("Name can't be blank")).to be true
    end

    it "has 'Price can't be blank' error when price_cents is nil" do
      @category = Category.create(id: 1, name: "Cardboard")
      @product = Product.create(id: 1, name: "Box", price_cents: nil, quantity: 10, category_id: 1)

      expect(@product.errors.full_messages.include?("Price can't be blank")).to be true
    end

    it "has 'Quantity can't be blank' error when quantity is nil" do
      @category = Category.create(id: 1, name: "Cardboard")
      @product = Product.create(id: 1, name: "Box", price_cents: 10000, quantity: nil, category_id: 1)

      expect(@product.errors.full_messages.include?("Quantity can't be blank")).to be true
    end

    it "has 'Category can't be blank' error when category is nil" do
      @product = Product.create(id: 1, name: "Box", price_cents: 10000, quantity: 10, category_id: nil)

      expect(@product.errors.full_messages.include?("Category can't be blank")).to be true
    end
  end
end
