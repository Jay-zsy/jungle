require "rails_helper"

RSpec.feature "Visitor navigates to products details page", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: "Apparel"

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset("apparel1.jpg"),
        quantity: 10,
        price: 64.99,
      )
    end
  end

  scenario "They see all products" do
    # ACT
    visit root_path

    # DEBUG / VERIFY
    expect(page).to have_css "article.product", count: 10
    # save_screenshot
  end

  scenario "They see the product details" do
    # ACT
    visit root_path
    page.find(".pull-right", match: :first).click
    page.find(".main-img")

    # DEBUG / VERIFY
    expect(page).to have_css ".main-img", count: 1
    expect(page).to have_content "Name", count: 1
    expect(page).to have_content "Description", count: 1
    expect(page).to have_content "Quantity", count: 1
    expect(page).to have_content "Price", count: 1
    # save_screenshot
  end
end
