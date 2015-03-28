

def create_user_owner
  User.create!(
    first_name: "Al",
    last_name: "Steiner",
    email: "al@gmail.com",
    password:"al",
    password_confirmation: "al"
    )
end

def create_project
  Project.create!(
    name: 'Godzilla'
  )
end

def create_owner_membership(user,project)
  Membership.create!(
    user_id: user.id,
    project_id: project.id,
    role: "owner"
  )
end

def create_user
  User.create!(
    first_name: "Joe",
    last_name: "Steiner",
    email: "js@gmail.com",
    password:"js",
    password_confirmation: "js"
    )
end

def create_member_membership(user,project)
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
