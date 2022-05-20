Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "/merchants/find", to: "search#find_merchant"
      get "/items/find_all", to: "search#find_items"
      resources :merchants, only: [:index, :show] do
        resources :items, controller: "merchant_items", only: [:index]
      end
      resources :items do
        resources :merchant, controller: "item_merchant", only: [:index]
      end
    end
  end
end
