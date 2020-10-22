Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
   namespace :v1 do
     namespace :merchants do
       get '/:merchant_id/items', to: 'items#index'
       get '/find', to: 'find#show'
       get '/find_all', to: 'find#index'
       get '/most_revenue', to: 'revenue#most_revenue'
       get '/most_items', to: 'revenue#most_items'
       get '/:id/revenue', to: 'revenue#total_revenue'

     end
     resources :merchants, only: [:index, :show, :create, :update, :destroy]
    end
  end

  namespace :api do
   namespace :v1 do
     namespace :items do
       get '/:item_id/merchant', to: 'merchants#index'
       get '/find', to: 'find#show'
       get '/find_all', to: 'find#index'
     end
     resources :items, only: [:index, :show, :create, :update, :destroy]
    end
  end

  namespace :api do
   namespace :v1 do
     get '/revenue', to: 'revenue#index'
   end
 end 

end
