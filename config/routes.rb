ExpenseReport::Application.routes.draw do

  resources :companies
  resources :currencies
  match '/currencies/:from_currency_id/get_exchange_rate/:to_currency_id', to: 'currencies#get_exchange_rate', via: :get
  resources :expenses, shallow: true do
    resources :expense_details
    resources :expense_attachments
    put 'change_state', on: :member
    get 'owned', on: :collection
    get 'submitted', on: :collection
    get 'transition_buttons', on: :member
  end
  resources :expense_statuses
  resources :expense_types
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :replace_expense_owners, only: [:new, :create]
  resources :replace_user_managers, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :user_types

  root to: 'static_pages#home'
  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  match '/delayed_job' => DelayedJobWeb, :anchor => false


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
