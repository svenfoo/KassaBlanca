Rails.application.routes.draw do

  # See how all your routes lay out with "rake routes".

  resources :tickets do
    post :check_in
    post :check_out
  end

  root 'tickets#index'

end
