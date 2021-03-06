Rails.application.routes.draw do
  devise_for :users, class_name: 'User',
             controllers: {omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations'}

  devise_scope :user do
    get '/users/auth/:provider/upgrade' => 'omniauth_callbacks#upgrade', as: :user_omniauth_upgrade
    get '/users/auth/:provider/setup', to: 'omniauth_callbacks#setup'
  end

  root 'home#show'

  resource :home, only: :show, controller: :home

  namespace :user do
    resources :expenses do
      collection do
        post :import
      end
    end
    resources :weekly_expenses, only: :index
    resources :weekly_expenses_mails do
      collection do
        get :send_expenses_mail
      end
    end
    resources :groups_expenses, only: [:show, :index]
    resources :weekly_groups_expenses, only: [:index, :show]
    resources :weekly_groups_expenses_mails do
      member do
        get :send_group_expenses_mail
      end
    end
    resources :shop_items, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  resources :currencies, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :currency_exchange, only: :index
  resources :currency_exchange_settings, only: [:create, :destroy]
  resources :currency_rates, only: :index
  resources :groups
  resources :expenses_categories, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :shops, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :google_search, only: :index
  resources :google_queries, only: :index do
    collection do
      get :send_statistics_mail
    end
  end

  namespace :api do
    namespace :v1 do
      resources :currencies, only: [:index, :show, :create, :update, :destroy]
      resources :expenses, only: [:index, :show, :create, :update, :destroy]
      resources :expenses_categories, only: [:index, :show, :create, :update, :destroy]
      resources :groups, only: [:index, :show, :create, :update, :destroy]
      resources :shops, only: [:index, :show, :create, :update, :destroy]
      resources :shop_items, only: [:index, :show, :create, :update, :destroy]
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
