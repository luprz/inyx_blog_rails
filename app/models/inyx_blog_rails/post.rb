module InyxBlogRails
  class Post < ActiveRecord::Base
    mount_uploader :image, ImageUploader
    belongs_to :user
    acts_as_taggable
    acts_as_taggable_on :tags

  	def as_json(options={})
  		{
  			id: self.id,
  			title: self.title,
  			autor: self.user.name.humanize,
  			content: self.content,
  			public: self.public ? "Publicado" : "Despublicado",
  			created_at: self.created_at,
  			updated_at: self.updated_at
  		}
  	end

  end
end
