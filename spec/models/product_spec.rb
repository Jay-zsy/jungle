require "rails_helper"

RSpec.describe Product, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe "Validations" do
    let(:category) { Category.create(name: "sports") }
    let(:product) { category.products.build(name: "Golden Ball", price_cents: 100000, quantity: 100) }

    it "should save with all params given" do
      expect(product.save).to be true
    end

    it "should not save without a name" do
      product.assign_attributes(name: nil)
      product.valid?
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it "should not save without a price" do
      product.assign_attributes(price_cents: nil)
      product.valid?
      expect(product.errors.full_messages).to include("Price cents is not a number")
    end

    it "should not save without a quantity" do
      product.assign_attributes(quantity: nil)
      product.valid?
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "should not save without a category" do
      product.assign_attributes(category: nil)
      product.valid?
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
