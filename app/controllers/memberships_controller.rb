
class MembershipsController < ApplicationController

  before_action :target_project
  before_action :ensure_member
  before_action :ensure_owner, only: [:create,:update]
  before_action :ensure_owner_or_memberself, only: [:destroy]
  before_action do
    @membership_types=['member','owner']
  end

  def index
    @project=Project.find(params[:project_id])
    @memberships = @project.memberships
    @membership = Membership.new
  end

  def create
    @project=Project.find(params[:project_id])
    @membership=Membership.new(membership_params.merge(project_id: params[:project_id]))
    if @membership.save
      flash[:notice]= @membership.user.full_name + " was successfully added"
      redirect_to project_memberships_path
    else
      @memberships = @project.memberships
      render :index
    end
  end

  def update

    @project=Project.find(params[:project_id])
    @memberships = @project.memberships
    @membership=Membership.find(params[:id])
    all_owners = @memberships.where(role: "owner")

    if all_owners.count == 1 && @membership.role == "owner" && params[:membership][:role]=="member"
      flash[:alert]= "Projects must have at least one owner"
      redirect_to project_memberships_path
    elsif @membership.update(membership_params.merge(project_id: params[:project_id]))
      flash[:notice]= @membership.user.full_name + " was successfully updated"
      redirect_to project_memberships_path
    else
      render :index
    end

  end

  def destroy
    @membership=Membership.find(params[:id])
    flash[:notice]=@membership.user.full_name + ' was successfully removed'
    if current_user.id == @membership.user_id && @membership.role="member"
      @membership.destroy
      redirect_to projects_path
    else
      @membership.destroy
      redirect_to project_memberships_path
    end
  end

  private

  def membership_params
    params.require(:membership).permit(:user_id,:role)
  end

  def target_project
    @project=Project.find(params[:project_id])
  end

end
