
require 'rails_helper'


feature "Tasks" do

  before :each do

    User.destroy_all
    user=create_user
    project=create_project
    membership=create_membership(user,project)
    task=create_task(project)

  end

  scenario "user can create, read, update and delete a task" do

    visit root_path
    click_link 'Sign In'
    fill_in "Email", with: "js@gmail.com"
    fill_in "Password", with: 'js'
    click_button 'Sign In'

    expect(current_path).to eq '/projects'

    find('table.table').click_on 'Godzilla'

    click_link '1 Task'
    expect(page).to have_content 'New Task'

    click_link 'Smell'
    expect(page).to have_content 'Smell'

    click_link 'Edit'
    expect(page).to have_content 'Edit Task'

    fill_in "Description", with: "Push"
    fill_in "Due date", with: "01/01/2015"
    click_button 'Update Task'

    expect(page).to have_content 'Task was successfully updated!'
    expect(page).to have_content 'Push'

    click_link 'New Task'
    expect(page).to have_content 'New Task'
    fill_in "Description", with: "Smile"
    fill_in "Due date", with: "01/01/2015"
    click_button 'Create Task'

    expect(page).to have_content 'Task was successfully created!'

    visit '/projects'
    find('table.table').click_on 'Godzilla'

    expect(page).to have_content 'Godzilla'

    click_link 'Delete'
    expect(page).to have_no_content 'Godzilla'

  end

  scenario "user can see validation message for new task" do

    visit root_path
    click_link 'Sign In'
    fill_in "Email", with: "js@gmail.com"
    fill_in "Password", with: 'js'
    click_button 'Sign In'

    expect(current_path).to eq '/projects'

    find('table.table').click_on 'Godzilla'

    click_link '1 Task'
    expect(page).to have_content 'New Task'

    click_link 'New Task'

    expect(page).to have_content 'New Task'
    fill_in "Description", with: ""
    fill_in "Due date", with: "01/01/2015"
    click_button 'Create Task'

    expect(page).to have_content 'Description can\'t be blank'

  end

end
