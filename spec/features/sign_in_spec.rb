
require 'rails_helper'



feature 'Sign In' do

  scenario 'User can sign in' do

    User.create!(first_name: "a", last_name: "a", email: "a@ex.com", password: "a" )

    visit root_path
    click_link 'Sign In'
    fill_in "Email", with: "a@ex.com"
    fill_in "Password", with: 'a'
    click_button 'Sign In'

    expect(current_path).to eq root_path

    expect(page).to have_content 'You have successfully signed in'

  end

  scenario 'User can see validation messages on sign in' do

    visit root_path
    click_link 'Sign In'
    fill_in "Email", with: ""
    fill_in "Password", with: 'a'
    click_button 'Sign In'
    expect(page).to have_content 'Email / Password combination is invalid'

    visit root_path
    click_link 'Sign In'
    fill_in "Email", with: "a@ex.com"
    fill_in "Password", with: ''
    click_button 'Sign In'
    expect(page).to have_content 'Email / Password combination is invalid'


  end

end
