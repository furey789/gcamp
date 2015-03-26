class TasksController < ApplicationController

    before_action :ensure_current_user

    before_action :ensure_member

    def index
      @project=Project.find(params[:project_id])
      @tasks = @project.tasks
    end

    def new
      @project=Project.find(params[:project_id])
      @task = @project.tasks.new
    end

    def create
      @project=Project.find(params[:project_id])
      @task = @project.tasks.new(task_params)
      if @task.save
        flash[:notice]="Task was successfully created!"
        redirect_to project_tasks_path(@project)
      else
        render :new
      end
    end

    def show
      @project=Project.find(params[:project_id])
      @task = @project.tasks.find(params[:id])
      @comment = Comment.new   #Always like this, not @task.comment.new
    end

    def edit
      @project=Project.find(params[:project_id])
      @task = @project.tasks.find(params[:id])
    end

    def update
      @project=Project.find(params[:project_id])
      @task = @project.tasks.find(params[:id])
      if @task.update(task_params)
        flash[:notice]="Task was successfully updated!"
        redirect_to project_tasks_path(@project)
      else
        render :edit   # show edit form again
      end
    end

    def destroy
      @project=Project.find(params[:project_id])
      @task = @project.tasks.find(params[:id])
      @task.delete
      redirect_to project_tasks_path(@project)
    end

    private

    def task_params
      params.require(:task).permit(:description,:complete,:due_date,:project_id)
    end

    def ensure_current_user
      unless current_user
        flash[:alert]="You must sign in"
        redirect_to sign_in_path
      end
    end

    def ensure_member
      @project=Project.find(params[:project_id])
      if !@project.memberships.pluck(:user_id).include?(current_user.id)
        flash[:alert]="You do not have access to that project"
        redirect_to projects_path
      end
    end

end
