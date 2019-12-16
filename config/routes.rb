Rails.application.routes.draw do
  root to: 'welcome#index'

  get 'welcome', to: 'welcome#index', as: :welcome
  
  get 'about', to: 'about#index', as: :about

  get 'families', to: 'families#index', as: :families
  get 'families/:acronym', to: 'families#show', as: :family

  get 'controls', to: 'controls#index', as: :controls
  get 'controls/:number', to: 'controls#show', as: :control

  get 'statements', to: 'statements#index', as: :statements
end
