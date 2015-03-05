
require 'rails_helper'


feature "Tasks" do

  before :each do
    User.destroy_all
    user=User.create!(first_name: "Joe", last_name: "Steiner", email: "js@gmail.com",
      password:"js", password_confirmation: "js")
  end

  scenario "user can create, read, update and delete a task" do

    visit root_path
    click_link 'Sign In'
    fill_in "Email", with: "js@gmail.com"
    fill_in "Password", with: 'js'
    click_button 'Sign In'

    click_link 'Tasks'
    expect(current_path).to eq '/tasks'

    click_link 'New Task'

    expect(page).to have_content 'New Task'
    fill_in "Description", with: "Jump rope"
    fill_in "Due date", with: "01/01/2015"
    click_button 'Create Task'

    expect(page).to have_content 'Task was successfully created!'
    expect(page).to have_content 'Jump rope'

    click_link 'Edit'
    expect(page).to have_content 'Jump rope'

    fill_in "Description", with: "Jump da rope"
    click_button 'Update Task'

    expect(page).to have_content 'Task was successfully updated!'

    visit '/tasks'

    expect(page).to have_content 'Jump da rope'

    click_link 'Delete'
    expect(page).to have_no_content 'Jump da rope'

  end

  scenario "user can see validation message for new task" do

    visit root_path
    click_link 'Sign In'
    fill_in "Email", with: "js@gmail.com"
    fill_in "Password", with: 'js'
    click_button 'Sign In'

    click_link 'Tasks'
    expect(current_path).to eq '/tasks'

    click_link 'New Task'

    expect(page).to have_content 'New Task'
    fill_in "Description", with: ""
    fill_in "Due date", with: "01/01/2015"
    click_button 'Create Task'

    expect(page).to have_content 'Description can\'t be blank'

  end

end
