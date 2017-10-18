Rails.application.routes.draw do
  # get('products/new', {to: 'products#new', as: :new_product})
  # post('products/new', {to: 'products#create', as: :products})
  # get('products', {to: 'products#index'})
  # get('products/:id', {to: 'products#show', as: :product})
  # patch('products/:id', {to: 'products#update'})
  # delete('products/:id', {to: 'products#destroy'})
  # get('products/:id/edit', {to: 'products#edit', as: :edit_product})

  resources :products do
    resources :reviews, shallow: true, only: [:create, :destroy]
  end

  resources :users, only: [:create,:new]
  resource :session, only: [:new, :create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get('/about', {to: 'welcome#about'})
  get('/home', {to: 'welcome#home', as: :home})
  get('contact_us', {to: 'contact#contact_us'})
  post('contact_us', {to: 'contact#thank_you'})
  root('welcome#home')
end
