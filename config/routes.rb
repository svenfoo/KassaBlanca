Rails.application.routes.draw do

  # See how all your routes lay out with "rake routes".

  resources :tickets do
    post :check_in
    post :check_out
  end

  post '/check_in_with_new', to: "tickets#check_in_with_new"
  root 'tickets#index'
end
