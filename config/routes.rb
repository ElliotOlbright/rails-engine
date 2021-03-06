Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :customers, only: [:index]

      namespace :merchants do  
        get 'find', to: "search#show"
        get 'most_items', to: 'items_sold#index'
      end 

      namespace :items do 
        get 'find_all', to: "search#show"
      end 

      resources :merchants, only: [:index, :show] do 
        resources :items, only: [:index], module: :merchants
      end

      resources :items, only: [:index, :show, :create, :update, :destroy] do 
        resources :merchant, only: [:index], module: :items
      end 

      namespace :revenue do
				resources :merchants, only: [:index, :show]
			end
    end
  end
end
