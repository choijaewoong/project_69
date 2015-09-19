Rails.application.routes.draw do
  devise_for :users,  :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  root 'board#main#색동_저고리'
  
  match ":controller(/:action(/:id))", :via => [:post, :get]

end
