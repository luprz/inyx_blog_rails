module InyxBlogRails
  class Post < ActiveRecord::Base
  	def as_json(options={})
  		{
  			id: self.id,
  			title: self.title,
  			autor: self.autor,
  			content: self.content,
  			public: self.public ? "Publicado" : "Despublicado",
  			created_at: self.created_at,
  			updated_at: self.updated_at
  		}
  	end
  end
end
