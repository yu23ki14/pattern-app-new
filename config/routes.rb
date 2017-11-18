Rails.application.routes.draw do
  
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  #patterns route
  resources :patterns, only: [:index] do
    collection do
      get ':language_id' => 'patterns#show'
      get ':language_id/:pattern_no' => 'patterns#details'
      post ':language_id/:pattern_no/fav' => 'patterns#fav'
    end
  end
  
  resources :practices, only: [:index, :create, :update] do
    collection do
      get '/complete' => 'practices#complete'
      get '/:id/addcomment' => 'practices#addcomment'
      get '/:language_id/:pattern_no/detail' => 'practices#patterndetail'
      get '/archive' => 'practices#archive'
      post '/:id/did' => 'practices#did'
    end
  end
  
  #languages route
  resources :languages, only: [:index, :show]
  
  #recommends route
  resources :recommends, only: [:index, :update] do
    collection do
      post '/:phase_1_value/new' => 'recommends#recommend'
      get '/:phase_1_id/gophase2' => 'recommends#phase2'
      get '/:phase_2_id/gophase3' => 'recommends#phase3'
      get '/:phase_3_id/gophase4' => 'recommends#phase4'
      get '/:phase_4_id/gorecommend' => 'recommends#recommend'
    end
  end
  
  #static_pages route
  resources :static_pages, only: [:index] do
    collection do
      get '/privacy_policy' => 'static_pages#privacy_policy'
      get '/service_agreement' => 'static_pages#service_agreement'
      get '/vision' => 'static_pages#vision'
    end
  end
  
  #categories route
  resources :categories, only: [:index]
  root 'welcome#index'

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
