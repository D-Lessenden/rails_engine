Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
   namespace :v1 do
     namespace :merchants do
       get '/:merchant_id/items', to: 'items#index'
       get '/find', to: 'find#show'
       get '/find_all', to: 'find#index'
     end
     resources :merchants, only: [:index, :show, :create, :update, :destroy]
    end
  end

  namespace :api do
   namespace :v1 do
     namespace :items do
       get '/:item_id/merchant', to: 'merchants#index'
     end
     resources :items, only: [:index, :show, :create, :update, :destroy]
    end
  end

end
