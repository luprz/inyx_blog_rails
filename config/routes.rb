InyxBlogRails::Engine.routes.draw do

  scope :admin do
    get 'angular/category/:id/subcategories', to: 'angular#subcategories'
    get 'angular/posts/:id', to: 'angular#post'
  end


  scope :admin do
  	resources :posts do
  		collection do
	  		get '/angular_index', to: 'posts#angular_index'
	  		post '/delete', to: 'posts#delete'
	  	end
  	end
  end

  scope :admin do
    resources :categories do
      collection do
        get '/angular_index', to: 'categories#angular_index'
        post '/delete', to: 'categories#delete'
      end
    end
  end

end
