Rails.application.routes.draw do
  post 'validation/validate'
  root 'validation#new', as: 'validation_new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
