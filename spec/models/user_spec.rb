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

    it "should not create user when email (case insensitive) is not unique" do
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

  describe '.authenticate_with_credentials' do
    it "should return a user hash if email (case insensitive) and password are correct" do
      user_params = { first_name: "Timmy", last_name: "Taco", email: "timmy@taco.com", password: "12345678", password_confirmation: "12345678" }
      @user = User.new(user_params)
      @user.save

      expect(User.authenticate_with_credentials("TiMmy@tAcO.com", "12345678").class).to be User
    end

    it "should return a user hash if email (ignoring whitespace) and password are correct" do
      user_params = { first_name: "Timmy", last_name: "Taco", email: "timmy@taco.com", password: "12345678", password_confirmation: "12345678" }
      @user = User.new(user_params)
      @user.save

      expect(User.authenticate_with_credentials("  timmy@taco.com  ", "12345678").class).to be User
    end

    it "should return nil if email is incorrect" do
      user_params = { first_name: "Timmy", last_name: "Taco", email: "timmy@taco.com", password: "12345678", password_confirmation: "12345678" }
      @user = User.new(user_params)
      @user.save

      expect(User.authenticate_with_credentials("timmy@taco.co", "12345678")).to be nil
    end

    it "should return nil if password is incorrect" do
      user_params = { first_name: "Timmy", last_name: "Taco", email: "timmy@taco.com", password: "12345678", password_confirmation: "12345678" }
      @user = User.new(user_params)
      @user.save

      expect(User.authenticate_with_credentials("timmy@taco.com", "1234567")).to be nil
    end
  end
end
