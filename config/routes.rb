V1foodoo::Application.routes.draw do
  devise_for :users

  resources :searches, only: [:new, :index]
  resources :restaurants
  resources :follows

  resources :choices

  resources :lists

  resources :users, :only => [:index, :show]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'lists#new'
  post 'restaurants/:id' => 'restaurants#show'
  match 'searches/new' => 'searches#new', via: [:get, :post]
  get 'restaurant' => 'restaurants#show'
  post 'lists/create' => 'lists#create'
  get 'user/list' => 'user#list'
  get '/mylist' => 'lists#mylist'
  get 'lsearch' => 'users#index'
  post 'users/getall' =>  'users#getall'
  post 'favorite' => 'restaurants#favorite'
  post 'unfavorite' => 'restaurants#unfavorite'
  post 'searches/set_user_location' => 'searches#set_user_location'
  get 'searches/group' => 'searches#group'
  post 'users/address_input' => 'users#address_input'
  get 'restaurants' => 'restaurants#index'
  post '/address_input' => 'restaurants#address_input'
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
