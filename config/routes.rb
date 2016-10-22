Rails.application.routes.draw do
  config = Rails.application.config.baukis

  constraints host: config[:staff][:host] do
    namespace :staff, path: config[:staff][:path] do
      root 'top#index'
      get 'login' => 'sessions#new', as: :login
      resource :session, only: [ :create, :destroy ]
      resource :account, except: [ :new, :create, :destroy ]
      resource :password, only: [ :show, :edit, :update ]
      resources :customers
    end
  end

  constraints host: config[:admin][:host] do
    namespace :admin, path: config[:admin][:path] do
      root 'top#index'
      get 'login' => 'sessions#new', as: :login
      resource :session, only: [ :create, :destroy ]
      resources :staff_members do
        resources :staff_events, only: [ :index ]
      end
      resources :staff_events, only: [ :index ]
    end
  end

  constraints host: config[:customer][:host] do
    namespace :customer, path: config[:customer][:path] do
      root 'top#index'
    end
  end

  root 'errors#not_found'
  get '*anything' => 'errors#not_found'
end
    #staff
    # post 'session' => 'sessions#create', as: :session
    # delete 'session' => 'sessions#destroy'

    # get 'account' => 'accounts#show', as: :staff_account
    # get 'account/new' => 'accounts#new', as: :new_staff_account 除外
    # get 'account/edit' => 'accounts#edit', as: :edit_staff_account
    # post 'account' => 'accounts#create', as: :staff_account 除外
    # patch 'account' => 'accounts#update', as: :staff_account
    # delete 'account' => 'accounts#destroy', as: :staff_account 除外

    #admin
    # post 'session' => 'sessions#create', as: :session
    # delete 'session' => 'sessions#destroy'

    # get 'staff_members' => 'staff_members#index', as: :admin_staff_member
    # get 'staff_members/:id' => 'staff_members#show', as: :admin_staff_member
    # get 'staff_members/new' => 'staff_members#new', as: :new_admin_staff_member
    # get 'staff_members/:id/edit' => 'staff_members#edit', as: :edit_admin_staff_member
    # post 'staff_members' => 'staff_members#create', as: :admin_staff_members
    # patch 'staff_members/:id' => 'staff_members#update', as: :admin_staff_member
    # delete 'staff_members/:id' => 'staff_members#destroy', as: :admin_staff_member
