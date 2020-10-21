require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'After creation' do
    before :each do
      @category = Category.create(id: 1, name: "stuff")
      @product1 = Product.create!(
        id: 1,
        name:  'Optimal Sleeping Bed',
        description: Faker::Hipster.paragraph(4),
        image: open_asset('furniture1.jpg'),
        quantity: 320,
        price: 3_052.00,
        category_id: 1
      )
      @product2 = Product.create!(
        id: 2,
        name:  'Electric Chair',
        description: Faker::Hipster.paragraph(4),
        image: open_asset('furniture2.jpg'),
        quantity: 200,
        price: 987.65,
        category_id: 1
      )
    end
    it 'deducts quantity from products based on their line item quantities' do
      @order = Order.new(
        id: 1,
        total_cents: 305_200,
        stripe_charge_id: 1,
        email: "timmy@taco.com"
      )

      @order.line_items.new(
        product_id: 1,
        quantity: 1,
        item_price_cents: 305_200,
        total_price_cents: 305_200,
      )

      @order.save!
      @product1.reload
      @product2.reload

      expect(@product1.quantity).to be 319
    end
    # pending test 2
    it 'does not deduct quantity from products that are not in the order' do
      @order = Order.new(
        id: 1,
        total_cents: 305_200,
        stripe_charge_id: 1,
        email: "timmy@taco.com"
      )

      @order.line_items.new(
        product_id: 1,
        quantity: 1,
        item_price_cents: 305_200,
        total_price_cents: 305_200,
      )

      @order.save!
      @product1.reload
      @product2.reload

      expect(@product2.quantity).to be 200

    end
  end
end