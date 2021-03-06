class ProjectsController < ApplicationController

  before_action :target_project, except: [:index,:new,:create]
  before_action :ensure_member, only: [:show,:edit,:update,:destroy]
  before_action :ensure_owner, only: [:edit,:update,:destroy]

  def index
    @projects=Project.all
    @tracker_projects = TrackerAPI.new.projects(current_user.token)
  end

  def new
    @project=Project.new
  end

  def create
    @project=Project.new(project_params)
    if @project.save
      assign_owner_to_project(@project)
      flash[:notice]="Project was successfully created"
      redirect_to project_tasks_path(@project)
    else
      render :new
    end
  end

  def show
    @project=Project.find(params[:id])
  end

  def edit
    @project=Project.find(params[:id])
  end

  def update
    @project=Project.find(params[:id])
    if @project.update(project_params)
      flash[:notice]="Project was successfully updated"
      redirect_to project_path(@project)
    else
      render :edit
    end
  end

  def destroy
    @project=Project.find(params[:id])
    @project.destroy
    flash[:notice]="Project was successfully deleted"
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end

  def target_project
    @project=Project.find(params[:id])
  end

  def assign_owner_to_project(project)
    @membership=Membership.new
    @membership.user_id=current_user.id
    @membership.project_id=project.id
    @membership.role='owner'
    @membership.save
  end

end
