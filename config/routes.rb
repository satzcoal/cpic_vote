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

    controller :vote_main_titles do
      scope :vote_mains do
        get ':id/titles/:title_index/up' => :title_up
        get ':id/titles/:title_index/down' => :title_down
        get ':id/titles/:title_index/edit' => :title_edit
        post ':id/titles/update' => :titles_update
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

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  get 'static_pages/home'

  root :to => 'static_pages#home', :as => 'home'
  #---------------------------------------LEE ADD END
end
