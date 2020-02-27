Rails.application.routes.draw do
  get "/search", to:"searches#search", as:"search"
  get 'relationships/create'
  get 'relationships/destroy'
  devise_for :users, :controllers => {
  	:registrations => "users/registrations"
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root :to => "homes#top"
get "home/about" => "homes#about"

resources :books do
	resources :books_comments,only: [:create,:destroy,:edit,:update]
	resource :favorites,only: [:create,:destroy]
end
resources :users do
	resource :relationships, only: [:create,:destroy]
	# 下記の２行はいつも通りの記述でも可
	get :follows, on: :member
	get :followers, on: :member
end

end
