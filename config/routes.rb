Rails.application.routes.draw do
  get "expense/index"

  get "sign_in_sheet/index"

  get "events/index"
  get "events/manage_event"
  get "sign_in_sheet/sign_in_sheet"
  post "sign_in_sheet/add_sign_in_sheet"
  patch "/sign_in_sheet/add_sign_in_sheet"
  get "expense/manage_event"
  get "events/compliance"
  post "/expense/add_event_details"
  patch "/expense/add_event_details"
  post "/events/add_compliance"
  devise_for :users
  get "welcome/index"
  resources :events do
    collection do
      post "check_lock_event"
      get "download_csv"
      post "filter_events"

    end


  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'events#index'

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
