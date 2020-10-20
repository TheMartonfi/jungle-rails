require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe "Validations" do
    it "saves succesfully if all fields are valid" do
      user_params = { first_name: "Timmy", last_name: "Taco", email: "timmy@taco.com", password: "12345678", password_confirmation: "12345678" }
      @user = User.new(user_params)

      expect(@user.save).to be true
    end

    it "should not create user when password and password_confirmation are not the same" do
      user_params = { first_name: "Timmy", last_name: "Taco", email: "timmy@taco.com", password: "12345678", password_confirmation: "12345679" }
      @user = User.new(user_params)

      expect(@user.save).to be false
    end

    it "should not create user when email is not unique regardless of case sensitivity" do
      user_params = { first_name: "Timmy", last_name: "Taco", email: "TiMMy@tacO.com", password: "12345678", password_confirmation: "12345678" }
      @user = User.new(user_params)
      @user.save

      user_params = { first_name: "Timmy", last_name: "Taco", email: "tImmY@TAco.com", password: "12345678", password_confirmation: "12345678" }
      @user = User.new(user_params)

      expect(@user.save).to be false
    end

    it "should not create user when email isn't provided" do
      user_params = { first_name: "Timmy", last_name: "Taco", password: "12345678", password_confirmation: "12345678" }
      @user = User.new(user_params)

      expect(@user.save).to be false
    end

    it "should not create user when first_name isn't provided" do
      user_params = { last_name: "Taco", email: "timmy@taco.com", password: "12345678", password_confirmation: "12345678" }
      @user = User.new(user_params)

      expect(@user.save).to be false
    end

    it "should not create user when last_name isn't provided" do
      user_params = { first_name: "Timmy", email: "timmy@taco.com", password: "12345678", password_confirmation: "12345678" }
      @user = User.new(user_params)

      expect(@user.save).to be false
    end

    it "should not create user when password length is below 8" do
      user_params = { first_name: "Timmy", last_name: "Taco", email: "timmy@taco.com", password: "123", password_confirmation: "123" }
      @user = User.new(user_params)

      expect(@user.save).to be false
    end
  end
end
