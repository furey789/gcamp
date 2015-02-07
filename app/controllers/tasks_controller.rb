class TasksController < ApplicationController

    def index
      @tasks = Task.all
    end

    def new
      @task = Task.new
    end

    # def show
    #   @task = Task.find(params[:id])
    # end

    # def edit
    # end
    #
    # def destroy
    # end

    private

    def task_params
      params.require(:task).permit(:title)
    end

end
