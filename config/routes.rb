Rails.application.routes.draw do
  # get('products/new', {to: 'products#new', as: :new_product})
  # post('products/new', {to: 'products#create', as: :products})
  # get('products', {to: 'products#index'})
  # get('products/:id', {to: 'products#show', as: :product})
  # patch('products/:id', {to: 'products#update'})
  # delete('products/:id', {to: 'products#destroy'})
  # get('products/:id/edit', {to: 'products#edit', as: :edit_product})

  resources :products do
    resources :favourites, shallow: true, only: [:create, :destroy, :index]
    resources :reviews, shallow: true, only: [:create, :destroy] do
      resources :likes, shallow: true, only: [:create, :destroy]
      resources :votes, only:[:create, :update, :destroy]
    end
  end

  post('/reviews/:id', {to: 'reviews#hide', as: :hide_review } )


  namespace :admin do
    resources :panel, only:[:index]
  end


  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :products
    end 
  end 

  resources :tags, only:[:index, :show]
  resources :users, only: [:create,:new, :show]
  resource :session, only: [:new, :create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get('/about', {to: 'welcome#about'})
  get('/home', {to: 'welcome#home', as: :home})
  get('contact_us', {to: 'contact#contact_us'})
  post('contact_us', {to: 'contact#thank_you'})
  root('welcome#home')
end
