require 'rails_helper'

RSpec.feature "Visitor can add product to cart and see cart size increase", type: :feature, js: true do

  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see the cart size increase" do
    visit root_path
    first("article.product").find_button("Add").click
    expect(find_link('My Cart (1)').visible?).to be true
  end
end
