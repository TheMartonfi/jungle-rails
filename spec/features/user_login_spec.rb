require 'rails_helper'

RSpec.feature "User can login", type: :feature, js: true do

  before :each do
    user_params = { id: 1, first_name: "Timmy", last_name: "Taco", email: "timmy@taco.com", password: "12345678", password_confirmation: "12345678" }
    @user = User.new(user_params)
    @user.save
  end

  scenario "A user can succesfully login" do
    visit root_path
    find_link("Login").click

    within("form") do
      fill_in 'email', with: "timmy@taco.com"
      fill_in "password", with: "12345678"
    end

    find_button("Submit").click
    expect(page).to have_link('Logout')
  end
end