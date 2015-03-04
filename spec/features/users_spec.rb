
require 'rails_helper'


feature "Users" do

  before :each do
    User.destroy_all
    user=User.create!(first_name: "Joe", last_name: "Steiner", email: "js@gmail.com",
      password:"js", password_confirmation: "js")
  end

  scenario "user can create another user" do

    visit root_path
    click_link 'Users'
    expect(current_path).to eq '/users'

    click_link 'New User'

    expect(page).to have_content 'New User'
    fill_in "First name", with: "Mo"
    fill_in "Last name", with: "Nee"
    fill_in "Email", with: "mn@ex.com"
    fill_in "Password", with: '123'
    fill_in "Password confirmation", with: '123'
    click_button 'Create User'

    expect(page).to have_content 'User was successfully created'
    expect(page).to have_content 'Users'

  end

  scenario "user can edit another user" do

    visit root_path
    click_link 'Users'
    expect(current_path).to eq '/users'

    click_link 'Edit'
    expect(page).to have_content 'Edit User'

    fill_in "First name", with: "Mo"
    fill_in "Last name", with: "Nee"
    fill_in "Email", with: "mn@ex.com"
    fill_in "Password", with: '123'
    fill_in "Password confirmation", with: '123'
    click_button 'Update User'

    expect(page).to have_content 'User was successfully updated'
    expect(page).to have_content 'Users'

  end

  scenario "user can delete another user" do

    visit root_path
    click_link 'Users'
    expect(current_path).to eq '/users'

    click_link 'Edit'
    expect(page).to have_content 'Delete User'

    click_link 'Delete User'
    expect(current_path).to eq '/users'
    expect(page).to have_content 'User was successfully deleted'

  end

  scenario "user can read about a user on show page" do

    visit root_path
    click_link 'Users'
    expect(current_path).to eq '/users'

    click_link 'Joe Steiner'
    expect(page).to have_content 'Joe Steiner'
    expect(page).to have_content 'js@gmail.com'

  end

  scenario "user sees validation message that first_name must be present" do

    visit root_path
    click_link 'Users'
    expect(current_path).to eq '/users'

    click_link 'New User'

    expect(page).to have_content 'New User'
    fill_in "First name", with: ""
    fill_in "Last name", with: "Nee"
    fill_in "Email", with: "mn@ex.com"
    fill_in "Password", with: '123'
    fill_in "Password confirmation", with: '123'
    click_button 'Create User'

    expect(page).to have_content 'First name can\'t be blank'

  end

end
