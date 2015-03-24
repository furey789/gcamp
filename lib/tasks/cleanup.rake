
namespace :cleanup do

  # This task "validated" via dependent: :destroy in users
  desc 'Removes all memberships where their users have already been deleted'
  task remove_memberships_with_no_users: :environment do
    user_ids=User.pluck(:id)
    Membership.all.each do |membership|
      if user_ids.include?(membership.user_id) == false
        membership.destroy
      end
    end
  end

  desc 'Removes all memberships where their projects have already been deleted'
  task remove_memberships_with_no_projects: :environment do
    project_ids=Project.pluck(:id)
    Membership.all.each do |membership|
      if project_ids.include?(membership.project_id) == false
        membership.destroy
      end
    end
  end

  # This task "validated" via dependent: :destroy in projects
  desc 'Removes all tasks where their projects have been deleted'
  task remove_tasks_with_no_projects: :environment do
    project_ids=Project.pluck(:id)
    Task.all.each do |task|
      if project_ids.include?(task.project_id) == false
        task.destroy
      end
    end
  end

  # This task "validated" via dependent: :destroy in tasks
  desc 'Removes all comments where their tasks have been deleted'
  task remove_comments_with_no_tasks: :environment do
    task_ids=Task.pluck(:id)
    Comment.all.each do |comment|
      if task_ids.include?(comment.task_id) == false
        comment.destroy
      end
    end
  end

  desc 'Sets the user_id of comments to nil if their users have been deleted'
  task set_comments_user_id_to_nil_if_no_user: :environment do
    user_ids=User.pluck(:id)
    Comment.all.each do |comment|
       if user_ids.include?(comment.user_id) == false
         comment.user_id = nil
         comment.save
       end
    end
  end

  desc 'Removes any tasks with null project_id'
  task remove_task_with_null_project_id: :environment do
    Task.all.each do |task|
      if task.project_id == nil
        task.destroy
      end
    end
  end

  desc 'Removes any comments with a null task_id'
  task remove_comments_with_null_task_id: :environment do
    Comment.all.each do |comment|
      if comment.task_id == nil
        comment.destroy
      end
    end
  end

  desc 'Removes any memberships with a null project_id or user_id'
  task remove_memberships_with_null_project_or_user_id: :environment do
    Membership.all.each do |membership|
      if membership.project_id == nil || membership.user_id == nil
        membership.destroy
      end
    end
  end

end
