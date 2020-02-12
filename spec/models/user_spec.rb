require "rails_helper"

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe "Validations" do
    let(:user) { User.new(first_name: "rice", last_name: "white", email: "waste@gmail.com", password: "12345", password_confirmation: "12345") }

    it "must be created with a password and password_confirmation fields" do
      user.assign_attributes(password_confirmation: "")
      user.valid?
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "will save with matching password and password confirmation" do
      user.valid?
      expect(user.save).to be true
    end

    it "should not save without a email" do
      user.assign_attributes(email: "")
      user.valid?
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it "should not save without a first name" do
      user.assign_attributes(first_name: "")
      user.valid?
      expect(user.errors.full_messages).to include("First name can't be blank")
    end

    it "should not save without a last name" do
      user.assign_attributes(last_name: "")
      user.valid?
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end

    it "should not save without a password length than 5" do
      user.assign_attributes(password: "123", password_confirmation: "123")
      user.valid?
      expect(user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
    end
  end

  describe ".authenticate_with_credentials" do
    let(:user) { User.create(first_name: "rice", last_name: "white", email: "waste@gmail.com", password: "12345", password_confirmation: "12345") }

    it "should authenticate with the user email" do
      expect(User.authenticate_with_credentials(user.email, user.password)).to eq(user)
    end

    it "should authenticate with the incorrect casing" do
      user.assign_attributes(email: "wAsTe@Gmail.COM")
      expect(User.authenticate_with_credentials(user.email, user.password)).to eq(user)
    end

    it "should authenticate with the incorrect spacing" do
      user.assign_attributes(email: "  wAsTe@Gmail.COM  ")
      expect(User.authenticate_with_credentials(user.email, user.password)).to eq(user)
    end
  end
end
