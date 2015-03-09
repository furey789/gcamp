
require 'rails_helper'

feature 'Sign Out' do

  scenario 'User can sign out' do

    User.create!(first_name: "a", last_name: "a", email: "a@ex.com", password: "a")

    visit root_path
    click_link 'Sign In'
    fill_in "Email", with: "a@ex.com"
    fill_in "Password", with: 'a'
    click_button 'Sign In'

    expect(current_path).to eq '/'
    expect(page).to have_content 'You have successfully signed in'

    click_link 'Sign Out'
    expect(current_path).to eq '/'
    expect(page).to have_content 'You have successfully logged out'

  end

end
