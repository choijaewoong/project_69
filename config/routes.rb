Rails.application.routes.draw do
  devise_for :users,  :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
    
    root 'board#main#78'
    
    match ":controller(/:action(/:id))", :via => [:post, :get]

end
