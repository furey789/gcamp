
def create_project
  Project.create!(
    :name => 'Godzilla'
  )
end

def create_task(project)
  Task.create!(
    :description => 'Smell',
    :project_id => project.id
  )
end
