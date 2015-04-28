require 'spec_helper'

feature 'customers enter order' do 

  scenario 'items are there' do
    visit '/'
    expect(page).to have_content 'Cafe Latte'
  end

  scenario 'compute link' do
    visit '/'
    expect(page).to have_link 'Compute'
  end
end
