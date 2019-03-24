Rails.application.routes.draw do
  # devise_for :users , controllers: { registrations: 'registrations',  :omniauth_callbacks => "users/omniauth_callbacks" } 
  devise_for :users , controllers: { :omniauth_callbacks => "users/omniauth_callbacks" } 
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
 end
 resources :friends


  root 'welcome#index'

  resources :groups

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


