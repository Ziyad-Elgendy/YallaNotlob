Rails.application.routes.draw do
  get 'order_details/index'
  devise_for :users , controllers: { registrations: 'registrations'} 
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
 end
 resources :order_details
 get 'welcome/order_details'
  # root 'welcome#order_details'
 get 'welcome/showFriends'
  # root 'welcome#showFriends'
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end


