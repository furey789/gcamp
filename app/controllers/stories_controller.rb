
class StoriesController < ApplicationController

  def index
    @projects=Project.all
    @tracker_projects = TrackerAPI.new.projects(current_user.token)
    @tracker_project=[]
    @tracker_projects.each do |track_proj|
      if track_proj[:id] == params[:tracker_project_id].to_i
        @tracker_project << track_proj
      end
    end
    @stories = TrackerAPI.new.stories(current_user.token,params[:tracker_project_id].to_s)
  end

end
