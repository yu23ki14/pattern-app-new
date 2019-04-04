Rails.application.routes.draw do
  
  ###Sub Domain
  
  require Rails.root.join('lib', 'subdomain.rb')
  
  constraints(Subdomain) do
    namespace :presentation, path: '/' do
      root 'welcome#index'
      
      resources :patterns, only: [:index, :show] do
      end
      
      resources :mypage, only: [:index] do
        collection do
          get '/posts' => 'mypage#posts'
          get '/patterns' => 'mypage#patterns'
        end
      end
      
      resources :posts, only: [:show, :new, :create, :index, :edit, :update, :destroy] do
        collection do
          get '/get_web_reference' => 'posts#get_web_reference'
        end
      end
      
      resources :post_comments, only: [:create, :destroy]
      
      resources :stocks, only: [:index]
      
      resources :user_interests, only: [:index]
      
      resources :about, only: [:index]
      
    end
  end
  
  ###Root Domain
  
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
      get '/:id/practice_comment' => 'practices#practice_comment'
      get '/archive' => 'practices#archive'
      get '/:id/edit_practice' => 'practices#edit_practice'
      post '/:id/did' => 'practices#did'
    end
  end
  
  resources :practice_comments, only: [:create]
  
  #languages route
  resources :languages, only: [:index, :show]
  
  #recommends route
  resources :recommends, only: [:index, :create, :update] do
    collection do
      get '/:phase_1_id/gophase2' => 'recommends#phase2'
      get '/:phase_2_id/gophase3' => 'recommends#phase3'
      get '/:phase_3_id/gophase4' => 'recommends#phase4'
      get '/:phase_4_id/gorecommend' => 'recommends#recommend'
      post '/:cat_code/cat_code' => 'recommends#cat_code'
    end
  end
  
  #static_pages route
  resources :static_pages, only: [:index] do
    collection do
      #get '/privacy_policy' => 'static_pages#privacy_policy'
      #get '/service_agreement' => 'static_pages#service_agreement'
      get '/vision' => 'static_pages#vision'
      get '/tutorial' => 'static_pages#tutorial'
      get '/sendgrid' => 'static_pages#sendgrid'
    end
  end
  
  #categories route
  resources :categories, only: [:index]
  
  #contact route
  resources :contacts, only: [:index, :create]
  
  #project route
  resources :projects, only: [:index, :create, :new, :show, :edit, :destroy, :update] do
    collection do
      get ':id/complete' => 'projects#complete'
      get ':id/archive' => 'projects#archive'
      get 'join' => 'projects#join'
      get 'search' => 'projects#search'
      get 'send_monday' => 'projects#send_monday'
    end
  end
  
  #project practice route
  resources :project_practices, only: [:create, :update] do
    collection do
      post '/:id/did' => 'project_practices#did'
      get '/:id/practice_comment' => 'project_practices#practice_comment'
      get '/:id/addcomment' => 'project_practices#addcomment'
      get '/:id/edit_practice' => 'project_practices#edit_practice'
    end
  end
  
  resources :project_practice_comments, only: [:create]
  
  resources :project_members, only: [:create, :destroy]
  
  resources :events, only: [:new, :create, :index, :show] do
    collection do
      get ':id/proximal' => 'events#proximal'
    end
  end
  
  resources :excharts, only: [:index, :new, :show, :create] do
    collection do
      get 'event' => 'excharts#event'
      get '/:language_id/:pattern_no/detail' => 'excharts#patterndetail'
      get ':id/pdf' => 'excharts#pdf'
      post ':id/pdf' => 'excharts#pdf'
      post ':id/send_pdf' => 'excharts#send_pdf'
      get 'compare' => 'excharts#compare'
      get 'compare/result' => 'excharts#compare_result'
    end
  end
  
  resources :alexa_talks, only: [:create]
  
  resources :shuffles, only: [:index] do
    collection do
      get 'app' => 'shuffles#app'
    end
  end
  
  resources :learning_styles
  
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
