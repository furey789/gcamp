
require 'rails_helper'

describe ProjectsController do

  before :each do
    Membership.destroy_all
    Project.destroy_all
    User.destroy_all
    user = create_user
    session[:user_id] = user.id
  end

  describe "GET#index" do

    it "renders the users index template" do
      get :index
      expect(response).to render_template("index")
    end

  end

  describe "GET#new" do

    it "renders the users new template" do
      get :new
      expect(response).to render_template("new")
    end

  end

  describe "POST#create" do

    it "redirects_to :action => :project_tasks_path" do

      project = create_project
      params = { id: project.id, project: {name: project.name }}
      post :create, params
      expect(response).to redirect_to("/projects/#{params[:id]+1}/tasks")
      expect(flash[:notice]).to eq("Project was successfully created")

    end

  end

  describe "GET#show" do

    it "renders the projects show template" do

      user = create_user(first_name: "Mo",
            last_name: "Steiner",
            email: "ms@gmail.com",
            password:"ms",
            password_confirmation: "ms",
            admin: false)

      session[:user_id]=user.id
      project = create_project
      membership = create_membership(user_id: session[:user_id], project_id: project.id)
      params = { id: project.id, project: {name: project.name }}
      get :show, params
      expect(response).to render_template("show")

    end

  end

  describe "GET#edit" do

    it "renders the projects edit template for member that's an owner" do

      user = create_user(first_name: "Mo",
            last_name: "Steiner",
            email: "ms@gmail.com",
            password:"ms",
            password_confirmation: "ms",
            admin: false)
      session[:user_id]=user.id
      project = create_project
      membership = create_membership(user_id: session[:user_id], project_id: project.id, role: "owner")

      params = { id: project.id, project: {name: project.name }}
      get :edit, params
      expect(response).to render_template("edit")

    end

  end

  describe "PATCH#update" do

    it "redirects_to :action => :show for member that's an owner" do

      user = create_user(first_name: "Mo",
            last_name: "Steiner",
            email: "ms@gmail.com",
            password:"ms",
            password_confirmation: "ms",
            admin: false)

      session[:user_id]=user.id
      project = create_project
      membership = create_membership(user_id: session[:user_id], project_id: project.id, role: "owner")

      params = { id: project.id, project: {name: project.name }}

      patch :update, params
      expect(response).to redirect_to("/projects/#{params[:id]}")
      expect(flash[:notice]).to eq("Project was successfully updated")

    end

  end

  describe "DELETE#destroy" do

    it "redirects_to :action => :index, for member that's an owner" do

      user = create_user(first_name: "Mo",
            last_name: "Steiner",
            email: "ms@gmail.com",
            password:"ms",
            password_confirmation: "ms",
            admin: false)

      session[:user_id]=user.id
      project = create_project
      membership = create_membership(user_id: session[:user_id], project_id: project.id, role: "owner")

      params = { id: project.id, project: {name: project.name }}

      patch :destroy, params
      expect(response).to redirect_to("/projects")
      expect(flash[:notice]).to eq("Project was successfully deleted")

    end

    it "redirects_to :action => :index, for member that's an admin" do

      user = create_user(first_name: "Mo",
            last_name: "Steiner",
            email: "ms@gmail.com",
            password:"ms",
            password_confirmation: "ms",
            admin: true)

      session[:user_id]=user.id
      session[:admin]=true
      project = create_project
      membership = create_membership(user_id: session[:user_id], project_id: project.id)

      # Need an owner for project (all projects must have owner) to pass conditional
      # statement of ensure_current_owner with admin
      user = create_user(first_name: "Bo",
            last_name: "Steiner",
            email: "bs@gmail.com",
            password:"bs",
            password_confirmation: "bs",
            admin: false)
      membership_owner = create_membership(user_id: user.id, project_id: project.id, role: "owner")

      params = { id: project.id, project: {name: project.name }}
      patch :destroy, params
      expect(response).to redirect_to("/projects")
      expect(flash[:notice]).to eq("Project was successfully deleted")

    end

  end

end
