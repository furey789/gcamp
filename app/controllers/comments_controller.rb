
class CommentsController < ApplicationController

  def create
    @project=Project.find(params[:project_id])
    @task = @project.tasks.find(params[:task_id])
    @comment=Comment.new(comment_params.merge(task_id: params[:task_id], user_id: current_user.id))
    if @comment.save
      redirect_to project_task_path(@project,@task)
    else
      redirect_to project_task_path(@project,@task)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:words,:user_id,:task_id)
  end

end
