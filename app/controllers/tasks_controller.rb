class TasksController < ApplicationController

    before_action :ensure_current_user

    before_action do
      @project=Project.find(params[:project_id])
    end


    def index
      @tasks = @project.tasks
    end

    def new
      @task = @project.tasks.new
    end

    def create
      @task = @project.tasks.new(task_params)
      if @task.save
        flash[:notice]="Task was successfully created!"
        redirect_to project_tasks_path(@project)
      else
        render :new
      end
    end

    def show
      @task = @project.tasks.find(params[:id])
    end

    def edit
      @task = @project.tasks.find(params[:id])
    end

    def update
      @task = @project.tasks.find(params[:id])
      if @task.update(task_params)
        flash[:notice]="Task was successfully updated!"
        redirect_to project_tasks_path(@project)
      else
        render :edit   # show edit form again
      end
    end

    def destroy
      @task = @project.task.find(params[:id])
      @task.destroy
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

end
