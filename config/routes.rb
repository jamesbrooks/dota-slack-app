Rails.application.routes.draw do
  # Authentication
  controller :sessions do
    match '/login/callback', action: 'create',  via: [ :get, :post ]
    match '/logout',         action: 'destroy', via: [ :get, :post ]
  end


  root to: 'dashboard#index'
end
