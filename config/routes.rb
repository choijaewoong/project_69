Rails.application.routes.draw do
  devise_for :users
  
  root 'board#main'
  
  match ":controller(/:action(/:id))", :via => [:post, :get]

end
