module InyxBlogRails
  class Post < ActiveRecord::Base
    mount_uploader :image, ImageUploader
    belongs_to :user
    belongs_to :category
    belongs_to :subcategory
    acts_as_taggable
    acts_as_taggable_on :tags

  	def as_json(options={})
  		{
  			id: self.id,
  			title: self.title,
  			autor: self.user.name.humanize,
        category: self.category.name.humanize,
        category_id: self.category_id,
        subcategory_name: self.subcategory.name,
        subcategory_id: self.subcategory_id,
        tags: self.tag_list.to_s,
  			content: self.content,
  			public: self.public ? "Publicado" : "Despublicado",
  			created_at: self.created_at,
  			updated_at: self.updated_at
  		}
  	end

  end
end
