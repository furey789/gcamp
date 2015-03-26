
require 'rails_helper'


feature "Projects" do

  before :each do
    User.destroy_all
    user=create_user
  end

  scenario "user can create, read, update and delete a task" do

    visit root_path
    click_link 'Sign In'
    fill_in "Email", with: "js@gmail.com"
    fill_in "Password", with: 'js'
    click_button 'Sign In'

    click_link 'Projects'
    expect(current_path).to eq '/projects'

    click_link 'New Project'

    expect(page).to have_content 'New Project'
    fill_in "Name", with: "Build an arc"
    click_button 'Create Project'

    expect(page).to have_content 'Project was successfully created'
    expect(page).to have_content 'Tasks for Build an arc'

    click_on 'Build an arc'
    expect(page).to have_content 'Build an arc Project'

    click_on 'Edit'
    expect(page).to have_content 'Edit Project'

    fill_in "Name", with: "Build some meaning into this"
    click_button 'Update Project'

    expect(page).to have_content 'Project was successfully updated'

    expect(page).to have_content 'Build some meaning into this'

    click_on 'Delete'
    expect(page).to have_no_content 'Build some meaning into this'

  end

  scenario "user can see validation message for new task" do

    visit root_path
    click_link 'Sign In'
    fill_in "Email", with: "js@gmail.com"
    fill_in "Password", with: 'js'
    click_button 'Sign In'

    click_link 'Projects'
    expect(current_path).to eq '/projects'

    click_link 'New Project'

    expect(page).to have_content 'New Project'
    click_button 'Create Project'

    expect(page).to have_content 'Name can\'t be blank'

  end

end
