InyxBlogRails::Engine.routes.draw do
	
  scope :admin do
  	resources :posts do
  		collection do
	  		get '/angular_index', to: 'posts#angular_index'
	  		post '/delete', to: 'posts#delete'
	  	end
  	end
  end

end
