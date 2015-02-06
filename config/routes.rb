Rails.application.routes.draw do
  #---------------------------------------LEE ADD START

  namespace :vote do

    resources :vote_mains

    get '1/start' => 'gonghui#start'
    get '1/stop' => 'gonghui#stop'
    get '1/score' => 'gonghui#score'
    get '1/renew' => 'gonghui#renew'
    get '1/over' => 'gonghui#over'

    get '2/start' => 'gonghui2#start'
    get '2/stop' => 'gonghui2#stop'
    get '2/score' => 'gonghui2#score'
    get '2/renew' => 'gonghui2#renew'
    get '2/over' => 'gonghui2#over'

    get '3/start' => 'jingfei#start'
    get '3/stop' => 'jingfei#stop'
    get '3/score' => 'jingfei#score'
    get '3/renew' => 'jingfei#renew'

    controller :jingfei do
      get 'jingfei' => :show
      get 'jingfei/vote_user/:item_id' => :vote_user, :as => 'jingfei_vote_user'
      get 'jingfei/unvote_user/:item_id' => :unvote_user, :as => 'jingfei_unvote_user'
      get 'jingfei/submit' => :submit, :as => 'jingfei_submit'
      get 'jingfei/edit' => :reedit, :as => 'jingfei_edit'
    end

    controller :gonghui do
      get 'gonghui' => :show
      get 'gonghui/vote_user/:item_id' => :vote_user, :as => 'gonghui_vote_user'
      get 'gonghui/unvote_user/:item_id' => :unvote_user, :as => 'gonghui_unvote_user'
      get 'gonghui/submit' => :submit, :as => 'gonghui_submit'
      get 'gonghui/edit' => :reedit, :as => 'gonghui_edit'
    end

    controller :gonghui2 do
      get 'gonghui2' => :show
      get 'gonghui2/vote_user/:item_id' => :vote_user, :as => 'gonghui2_vote_user'
      get 'gonghui2/unvote_user/:item_id' => :unvote_user, :as => 'gonghui2_unvote_user'
      get 'gonghui2/submit' => :submit, :as => 'gonghui2_submit'
      get 'gonghui2/edit' => :reedit, :as => 'gonghui2_edit'
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
