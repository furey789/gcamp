Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # Below equivalent to get '/' => 'welcome#index'
  # Add root controller
    root 'welcome#index'

  # Add other controllers
    get 'terms' => 'terms#view'
    get 'about' => 'about#view'
    get 'faq' => 'common_questions#view'
    resources :tasks, only: [:index, :new, :show]

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

end
