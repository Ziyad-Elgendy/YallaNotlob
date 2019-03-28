Rails.application.routes.draw do
  resources :activities
  # devise_for :users , controllers: { registrations: 'registrations',  :omniauth_callbacks => "users/omniauth_callbacks" } 
  devise_for :users , controllers: { :omniauth_callbacks => "users/omniauth_callbacks" } 
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
 end
 
 resources :orders do
  resources :order_items 
  resources :user_orders
  
 end
  get 'welcome/showFriends'
  resources :friends
  resources :notifications
  get 'friends_list' => 'friends#listF'     
  get 'groups_list' => 'groups#listG'     
  get 'make_all_read' => 'notifications#makeAllRead'
  get 'group_friend_list/:name' => 'groups#listGF'     

  root 'welcome#index'
  mount ActionCable.server => "/cable"

  resources :groups do
    post 'getName'
    post 'addFriend'
    delete 'deletefriend'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end


