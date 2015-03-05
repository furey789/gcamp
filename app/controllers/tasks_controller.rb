class TasksController < ApplicationController

    before_action :ensure_current_user

    def index
      @tasks = Task.all
    end

    def new
      @task = Task.new
    end

    def create
      @task = Task.new(task_params)
      if @task.save
        flash[:notice]="Task was successfully created!"
        redirect_to task_path(@task)
      else
        render :new
      end
    end

    def show
      @task = Task.find(params[:id])
    end

    def edit
      @task = Task.find(params[:id])
    end

    def update
      @task = Task.find(params[:id])
      if @task.update(task_params)
        flash[:notice]="Task was successfully updated!"
        redirect_to task_path(@task)
      else
        render :edit   # show edit form again
      end
    end

    def destroy
      @task = Task.find(params[:id])
      @task.destroy
      redirect_to tasks_path
    end

    private

    def task_params
      params.require(:task).permit(:description,:complete,:due_date)
    end

    def ensure_current_user
      unless current_user
        flash[:alert]="You must sign in"
        redirect_to sign_in_path
      end
    end

end
