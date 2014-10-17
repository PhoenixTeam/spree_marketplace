Spree::Core::Engine.routes.draw do
  namespace :admin do
    resource :marketplace_settings
    resources :suppliers do
      resources :bank_accounts, controller: 'supplier_bank_accounts'

      member do
        get :signup_cgv
        get :agree_cgv
        patch :update_from_cgv
        put :update_from_cgv
        patch :confirm_cgv
        put :confirm_cgv
        get :contract
      end
    end
  end

  resources :suppliers, only: [:create, :new]

end
