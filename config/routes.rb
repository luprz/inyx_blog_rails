InyxBlogRails::Engine.routes.draw do

  scope :admin do
    get 'angular/category/:id/subcategories', to: 'angular#subcategories'
    get 'angular/posts/:id', to: 'angular#post'
  end


  scope :admin, :blog do
  	resources :posts do
  		collection do
	  		get '/angular_index', to: 'posts#angular_index'
	  		post '/delete', to: 'posts#delete'
	  	end
  	end
  end

  scope :admin, :posts do
    resources :categories do
      collection do
        get '/angular_index', to: 'categories#angular_index'
        post '/delete', to: 'categories#delete'
      end
    end
  end

  scope :blog do
    get "/posts/:title", to: 'posts#show_front', as: "show_front_posts"
    get "/posts", to: 'posts#index_front', as: "index_front_posts"
  end

end
