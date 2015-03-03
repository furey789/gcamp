Rails.application.routes.draw do

    root 'welcome#index'

  # Add other controllers
    get 'terms' => 'terms#view'
    get 'about' => 'about#view'
    get 'faq' => 'common_questions#view'
    resources :tasks
    # , only: [:index, :new, :create, :show, :edit, :update]
    resources :users
    resources :projects
    get 'sign-up', to: "registrations#new"
    post 'sign-up', to: "registrations#create"
    
end
