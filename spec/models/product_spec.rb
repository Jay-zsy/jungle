require "rails_helper"

RSpec.describe Product, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe "Validations" do
    it "should save with all params given" do
      @category = Category.create(id: 1, name: "sports", created_at: DateTime.now.to_date, updated_at: DateTime.now.to_date)
      @product = Product.new(id: 1, name: "Golden Ball", price_cents: 100000, quantity: 100, category_id: 1, created_at: DateTime.now.to_date, updated_at: DateTime.now.to_date)
      expect(@product.save).to be true
    end

    it "should not save without a name" do
      @category = Category.create(id: 1, name: "sports", created_at: DateTime.now.to_date, updated_at: DateTime.now.to_date)
      @product = Product.new(id: 1, name: nil, price_cents: 100000, quantity: 100, category_id: 1, created_at: DateTime.now.to_date, updated_at: DateTime.now.to_date)
      @product.save
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it "should not save without a price" do
      @category = Category.create(id: 1, name: "sports", created_at: DateTime.now.to_date, updated_at: DateTime.now.to_date)
      @product = Product.new(id: 1, name: "Balls", price_cents: nil, quantity: 100, category_id: 1, created_at: DateTime.now.to_date, updated_at: DateTime.now.to_date)
      @product.save
      expect(@product.errors.full_messages).to include("Price cents is not a number")
    end

    it "should not save without a quantity" do
      @category = Category.create(id: 1, name: "sports", created_at: DateTime.now.to_date, updated_at: DateTime.now.to_date)
      @product = Product.new(id: 1, name: "Balls", price_cents: 10000, quantity: nil, category_id: 1, created_at: DateTime.now.to_date, updated_at: DateTime.now.to_date)
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "should not save without a category" do
      @category = Category.create(id: 1, name: "sports", created_at: DateTime.now.to_date, updated_at: DateTime.now.to_date)
      @product = Product.new(id: 1, name: "Balls", price_cents: 10000, quantity: 100, category_id: nil, created_at: DateTime.now.to_date, updated_at: DateTime.now.to_date)
      @product.save
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
