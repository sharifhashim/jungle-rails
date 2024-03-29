require 'rails_helper'

RSpec.feature "Visitor click one of the product partials and get to new page", type: :feature, js: true do

    # SETUP
    before :each do
      @category = Category.create! name: 'Apparel'

      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end

    scenario "They see product detail" do
      # ACT
      visit root_path
      find_link("Details »", match: :first).click
      sleep 5
      puts page.html
      # DEBUG
      save_screenshot
  
      # VERIFY
    expect(page).to have_content 'Quantity'
    end
  end