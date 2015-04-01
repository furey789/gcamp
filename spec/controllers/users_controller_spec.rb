
require 'rails_helper'

describe UsersController do

  before :each do
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

    it "redirects_to :action => :index" do

      params = { user: { first_name: "Mo",
            last_name: "Steiner",
            email: "ms@gmail.com",
            password:"ms",
            password_confirmation: "ms" } }

      post :create, params
      expect(response).to redirect_to(action: :index)
      expect(flash[:notice]).to eq("User was successfully created")

      params=nil

    end

  end

  describe "GET#show" do

    it "renders the users show template" do

      params = { id: session[:user_id] }
      get :show, params
      expect(response).to render_template("show")

    end

  end

  describe "GET#edit" do

    it "renders the users edit template" do

      params = { id: session[:user_id] }
      get :edit, params
      expect(response).to render_template("edit")

    end

  end

  describe "PATCH#update" do

    it "redirects_to :action => :index, for current_user Non-Admin and update user Non-Admin" do

      u = create_user(first_name: "Mo",
            last_name: "Steiner",
            email: "ms@gmail.com",
            password:"ms",
            password_confirmation: "ms",
            admin: false)

      params = {id: u.id, user: { first_name: u.first_name,
            last_name: u.last_name,
            email: u.email,
            password: u.password,
            password_confirmation: u.password,
            admin: u.admin} }

      patch :update, params
      expect(response).to redirect_to(action: :index)
      expect(flash[:notice]).to eq("User was successfully updated")

    end

    it "redirects_to :action => :index, for current_user Admin and update user Non-Admin" do

      session[:admin] = true

      u = create_user(first_name: "Mo",
            last_name: "Steiner",
            email: "ms@gmail.com",
            password:"ms",
            password_confirmation: "ms",
            admin: false)

      params = {id: u.id, user: { first_name: u.first_name,
            last_name: u.last_name,
            email: u.email,
            password: u.password,
            password_confirmation: u.password,
            admin: u.admin} }

      patch :update, params
      expect(response).to redirect_to(action: :index)
      expect(flash[:notice]).to eq("User was successfully updated")

    end

  end

  describe "DELETE#destroy" do

    it "redirects_to :action => :index, for not current_user" do

      u = create_user(first_name: "Mo",
            last_name: "Steiner",
            email: "ms@gmail.com",
            password:"ms",
            password_confirmation: "ms",
            admin: false)

      params = {id: u.id, user: { first_name: u.first_name,
            last_name: u.last_name,
            email: u.email,
            password: u.password,
            password_confirmation: u.password,
            admin: u.admin} }

      delete :destroy, params
      expect(flash[:notice]).to eq("User was successfully deleted")
      expect(response).to redirect_to(action: :index)

    end

    it "redirects_to :action => :root, for current_user Admin" do

      u = create_user(first_name: "Mo",
            last_name: "Steiner",
            email: "ms@gmail.com",
            password:"ms",
            password_confirmation: "ms",
            admin: true)

      session[:user_id]=u.id

      params = {id: u.id, user: { first_name: u.first_name,
            last_name: u.last_name,
            email: u.email,
            password: u.password,
            password_confirmation: u.password,
            admin: u.admin} }

      delete :destroy, params
      expect(response).to redirect_to("/#{assigns(:index)}")
    end

  end

end
