Rails.application.routes.draw do
  root 'page#index'
  post '/', to: 'page#run'
  
  #resources :scrapes
end
