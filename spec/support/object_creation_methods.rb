

def create_user_owner(options={})
  User.create!({
    first_name: "Al",
    last_name: "Steiner",
    email: "al@gmail.com",
    password:"al",
    password_confirmation: "al",
    admin: false,
  }.merge(options))
end

def create_project(options={})
  Project.create!({
    name: "Godzilla",
    created_at: 10-01-2005,
    updated_at: 10-02-2005
  }.merge(options))
end

def create_user(options={})
  User.create!({
    first_name: "Joe",
    last_name: "Steiner",
    email: "js@gmail.com",
    password:"js",
    password_confirmation: "js",
    admin: false,
    }.merge(options))
end

def create_membership(options={})
    Membership.create!({
      user_id: 1,
      project_id: 1,
      role: "member"
    }.merge(options))
end

def create_task(project)
  Task.create!(
    description: 'Smell',
    project_id: project.id
  )
end
