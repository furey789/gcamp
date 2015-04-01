
require 'rails_helper'

describe MembershipsController do

  before :each do
    Membership.destroy_all
    Project.destroy_all
    User.destroy_all
    user = create_user
    session[:user_id] = user.id
  end

  describe "GET#index" do

    it "renders the memberships index template" do

      user = create_user(first_name: "Mo",
            last_name: "Steiner",
            email: "ms@gmail.com",
            password:"ms",
            password_confirmation: "ms",
            admin: false)

      session[:user_id]=user.id
      project = create_project
      membership = create_membership(user_id: session[:user_id], project_id: project.id)

      get :index, project_id: project.id
      expect(response).to render_template("index")

    end

  end

  describe "POST#create" do

    it "redirects_to :action => :index, for memberships in a project" do

      # user that's owner of project
      user = create_user(first_name: "Mo",
            last_name: "Steiner",
            email: "ms@gmail.com",
            password:"ms",
            password_confirmation: "ms",
            admin: false)
      session[:user_id]=user.id
      project = create_project
      membership = create_membership(user_id: session[:user_id], project_id: project.id, role: "owner")

      # user that's member of same project
      user2 = create_user(first_name: "Bo",
            last_name: "Steiner",
            email: "bs@gmail.com",
            password:"bs",
            password_confirmation: "bs",
            admin: false)
      # Line below will add a membership.id that will conflict with creating new membership
      # membership2 = create_membership(user_id: user2.id, project_id: project.id, role: "member")

      params = { project_id: project.id, membership: {user_id: user2.id, role: "member"}}

      post :create, params

      expect(response).to redirect_to("/projects/#{params[:project_id]}/memberships")
      expect(flash[:notice]).to eq("#{user2.first_name} #{user2.last_name} was successfully added")

    end

  end

  describe "POST#update" do

    it "redirects_to :action => :index, for memberships in a project" do

      # user that's owner of project
      user = create_user(first_name: "Mo",
            last_name: "Steiner",
            email: "ms@gmail.com",
            password:"ms",
            password_confirmation: "ms",
            admin: false)
      session[:user_id]=user.id
      project = create_project
      membership = create_membership(user_id: session[:user_id], project_id: project.id, role: "owner")

      # user that's member of same project
      user2 = create_user(first_name: "Bo",
            last_name: "Steiner",
            email: "bs@gmail.com",
            password:"bs",
            password_confirmation: "bs",
            admin: false)
      # Line below will add a membership.id that will conflict with creating new membership
      membership2 = create_membership(user_id: user2.id, project_id: project.id, role: "member")

      params = { project_id: project.id, id: membership2.id, membership: {role: "member"}}

      post :update, params

      expect(response).to redirect_to("/projects/#{params[:project_id]}/memberships")
      expect(flash[:notice]).to eq("#{user2.first_name} #{user2.last_name} was successfully updated")

    end

  end

  describe "DELETE#destroy" do

    it "deletes and redirects_to :action => :index of memberships for project" do

      user = create_user(first_name: "Mo",
            last_name: "Steiner",
            email: "ms@gmail.com",
            password:"ms",
            password_confirmation: "ms",
            admin: false)

      session[:user_id]=user.id
      project = create_project
      membership = create_membership(user_id: session[:user_id], project_id: project.id, role: "owner")
      task = create_task(project_id: project.id)
      params = { project_id: project.id, id: membership.id, membership: {role: "member"} }

      patch :destroy, params

      expect(response).to redirect_to("/projects/#{params[:project_id]}")

    end

    it "deletes and redirects_to :action => :index of projects" do

      # user that's owner of project
      user = create_user(first_name: "Mo",
            last_name: "Steiner",
            email: "ms@gmail.com",
            password:"ms",
            password_confirmation: "ms",
            admin: false)
      session[:user_id]=user.id
      project = create_project
      membership = create_membership(user_id: session[:user_id], project_id: project.id, role: "owner")

      # user that's member of same project
      user2 = create_user(first_name: "Bo",
            last_name: "Steiner",
            email: "bs@gmail.com",
            password:"bs",
            password_confirmation: "bs",
            admin: false)
      # Line below will add a membership.id that will conflict with creating new membership
      membership2 = create_membership(user_id: user2.id, project_id: project.id, role: "member")

      params = { project_id: project.id, id: membership2.id, membership: {role: membership2.id} }

      patch :destroy, params

      expect(response).to redirect_to("/projects/#{params[:project_id]}/memberships")
      expect(flash[:notice]).to eq("#{user2.first_name} #{user2.last_name} was successfully removed")

    end

  end

end
