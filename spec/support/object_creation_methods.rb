

def create_user
  User.create!(
    first_name: "Joe",
    last_name: "Steiner",
    email: "js@gmail.com",
    password:"js",
    password_confirmation: "js"
    )
end

def create_project
  Project.create!(
    name: 'Godzilla'
  )
end

def create_membership(user,project)
  Membership.create!(
    user_id: user.id,
    project_id: project.id,
    role: "member"
  )
end

def create_task(project)
  Task.create!(
    description: 'Smell',
    project_id: project.id
  )
end
