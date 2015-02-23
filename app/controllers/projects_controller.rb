class ProjectsController < ApplicationController

  def index
    @projects=Project.all
  end

  def new
    @project=Project.new
  end

  def create
    @project=Project.new(project_params)
    @project.save
    if @project.save
      flash[:notice]="Project was successfully created"
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def show
    @project=Project.find(params[:id])
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end

end
