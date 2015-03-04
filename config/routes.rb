Rails.application.routes.draw do
  #---------------------------------------LEE ADD START

  namespace :vote do
    controller :vote_mains do
      scope :vote_mains do
        get ':id/enable' => :enable
        get ':id/process' => :begin
        get ':id/finish' => :finish
        get ':id/publish' => :publish
        get ':id/close' => :close
        get ':id/disable' => :disable
      end
    end
    resources :vote_mains

    controller :ins_votes do
      scope :ins_votes do
        get 'show_for_vote/:vote_id' => :show
        get ':ins_id/submit' => :submit
        get ':ins_id/edit' => :edit
        get ':ins_id/select/:item_id' => :select_item
        get ':ins_id/cancel/:item_id' => :cancel_item
      end
    end
  end

  namespace :origin do
    resources :sidebar_items
    resources :roles
    resources :users
    controller :sessions do
      get 'login' => :new
      post 'login' => :create
      get 'logout' => :destroy
      post 'ajax_authorize' => :ajax_authorize
      post 'ajax_changepass' => :ajax_changepass
    end

    controller :sites do
      get 'site' => :show, :as => :site
      get 'site/edit' => :edit, :as => :edit_site
      put 'site' => :update
      patch 'site' => :update
    end
  end

  get 'admin' => 'admin#index'
  get 'static_pages/403' => 'static_pages#page_403'

  #---------------------------------------LEE ADD END

  get 'static_pages/home'

  # You can have the root of your site routed with "root"
  root :to => 'static_pages#home', :as => 'home'

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
