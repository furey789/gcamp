
require 'rails_helper'

describe TasksController do

  before :each do
    Membership.destroy_all
    Project.destroy_all
    User.destroy_all
    user = create_user
    session[:user_id] = user.id
  end

  describe "GET#index" do

    it "renders the tasks index template" do

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

  describe "GET#new" do

    it "renders the tasks new template" do

      user = create_user(first_name: "Mo",
            last_name: "Steiner",
            email: "ms@gmail.com",
            password:"ms",
            password_confirmation: "ms",
            admin: false)

      session[:user_id]=user.id
      project = create_project
      membership = create_membership(user_id: session[:user_id], project_id: project.id)

      get :new, project_id: project.id
      expect(response).to render_template("new")
      
    end

  end

  describe "POST#create" do

    it "redirects_to :action => :show, for task in a project" do

      user = create_user(first_name: "Mo",
            last_name: "Steiner",
            email: "ms@gmail.com",
            password:"ms",
            password_confirmation: "ms",
            admin: false)

      session[:user_id]=user.id
      project = create_project
      membership = create_membership(user_id: session[:user_id], project_id: project.id)
      task = create_task(project_id: project.id)
      params = { project_id: project.id, task: {description: task.description, due_date: task.due_date,
         complete: task.complete}}

      post :create, params
      expect(response).to redirect_to("/projects/#{params[:project_id]}/tasks")
      expect(flash[:notice]).to eq("Task was successfully created!")

    end

  end


  describe "GET#show" do

    it "renders the tasks show template" do

      user = create_user(first_name: "Mo",
            last_name: "Steiner",
            email: "ms@gmail.com",
            password:"ms",
            password_confirmation: "ms",
            admin: false)

      session[:user_id]=user.id
      project = create_project
      membership = create_membership(user_id: session[:user_id], project_id: project.id)
      task = create_task(project_id: project.id)

      get :show, project_id: project.id, id: task.id   # no params needed
      expect(response).to render_template("show")

    end

  end

  describe "GET#edit" do

    it "renders the tasks edit template" do

      user = create_user(first_name: "Mo",
            last_name: "Steiner",
            email: "ms@gmail.com",
            password:"ms",
            password_confirmation: "ms",
            admin: false)

      session[:user_id]=user.id
      project = create_project
      membership = create_membership(user_id: session[:user_id], project_id: project.id)
      task = create_task(project_id: project.id)

      get :edit, project_id: project.id, id: task.id   # no params needed
      expect(response).to render_template("edit")

    end

  end

  describe "PATCH#update" do

    it "updates redirects_to :action => :index of tasks for project" do

      user = create_user(first_name: "Mo",
            last_name: "Steiner",
            email: "ms@gmail.com",
            password:"ms",
            password_confirmation: "ms",
            admin: false)

      session[:user_id]=user.id
      project = create_project
      membership = create_membership(user_id: session[:user_id], project_id: project.id)
      task = create_task(project_id: project.id)
      params = { project_id: project.id, id: task.id, task: {description: task.description, due_date: task.due_date,
         complete: task.complete}}
      # note: id: and project_id: provide path info, task: provides form params info

      patch :update, params
      expect(response).to redirect_to("/projects/#{params[:project_id]}/tasks")
      expect(flash[:notice]).to eq("Task was successfully updated!")

    end

  end

  describe "DELETE#destroy" do

    it "deletes and redirects_to :action => :index of tasks for project" do

      user = create_user(first_name: "Mo",
            last_name: "Steiner",
            email: "ms@gmail.com",
            password:"ms",
            password_confirmation: "ms",
            admin: false)

      session[:user_id]=user.id
      project = create_project
      membership = create_membership(user_id: session[:user_id], project_id: project.id)
      task = create_task(project_id: project.id)
      params = { project_id: project.id, id: task.id, task: {description: task.description, due_date: task.due_date,
         complete: task.complete} }

      patch :destroy, params
      expect(response).to redirect_to("/projects/#{params[:project_id]}/tasks")

    end

  end

end
