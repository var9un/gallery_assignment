Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "galleries#new"
  resources :galleries do
	collection do
      post "display", to: "galleries#display"
    end
  end	
end
