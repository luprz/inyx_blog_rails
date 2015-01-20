InyxBlogRails::Engine.routes.draw do

  scope :admin do
    get 'angular/category/:id/subcategories', to: 'angular#subcategories'
    get 'angular/posts/:id', to: 'angular#post'
  end


  scope :admin, :blog do
  	resources :posts do
  		collection do
	  		post '/delete', to: 'posts#delete'
	  	end
  	end
  end

  scope :admin, :posts do
    resources :categories do
      collection do
        post '/delete', to: 'categories#delete'
      end
    end
  end

  scope :blog do
    get "/posts/:title", to: 'posts#show_front', as: "show_front_posts"
    get "/posts", to: 'posts#index_front', as: "index_front_posts"
    get "/category/:category_permalink/posts", to: "posts#category_front", as: "index_category_posts"
    get "/category/:category_permalink/subcategory/:subcategory_permalink/posts", to: "posts#subcategory_front", as: "index_subcategory_posts"
    get "/tag/:permalink/posts", to: "posts#tag_front", as: "index_tag_posts"
    get "/autor/:permalink/posts", to: "posts#autor_front", as: "index_autor_posts"
  end

end
