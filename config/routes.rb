Rails.application.routes.draw do
  devise_for :users
  root "posts#index"
  post "comments/create"
  delete "comments/destroy/:id", to: 'comments#destroy', as: "comments_destroy"
  get "posts/my_posts"
  get "posts/discussed_posts"
  resources :posts
  get '*path' => redirect('/')
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
