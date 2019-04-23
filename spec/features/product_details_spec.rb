require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
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

  scenario "They can see product details" do
    # ACT
    visit root_path
    within 'footer' do
      find('a.pull-right').click
    end
    sleep 5
    # DEBUG / VERIFY
    save_screenshot
    expect(page).to have_content 'Product Reviews'
  end
end
