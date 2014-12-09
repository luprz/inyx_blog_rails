module InyxBlogRails
  class Post < ActiveRecord::Base
    before_save :downcase_title
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
        image: self.image.url,
  			autor: self.user.name.humanize,
        category_name: self.category.name.humanize,
        category_id: self.category_id,
        subcategory_name: "#{self.subcategory.nil? ? nil : self.subcategory.name}",
        subcategory_id: self.subcategory_id,
        tags: self.tag_list.to_s,
  			content: self.content.html_safe,
  			public: self.public ? "Publicado" : "Despublicado",
  			created_at: self.created_at,
  			updated_at: self.updated_at,
        category: Category.find(self.category_id),
        subcategory: self.subcategory.nil? ? nil : Subcategory.find(self.subcategory_id),
        permalink: self.permalink
  		}
  	end

    def permalink
      self.title.parameterize
    end

    private

    def downcase_title
     self.title = self.title.downcase  
    end

  end
end
