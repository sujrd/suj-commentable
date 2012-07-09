Rails.application.routes.draw do
  resources :comments, :only => [:create, :destroy] do
    put 'rate', :on => :member
  end
end
