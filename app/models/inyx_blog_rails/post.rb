module InyxBlogRails
  class Post < ActiveRecord::Base
    before_save :create_permalink
    mount_uploader :image, ImageUploader
    belongs_to :user
    belongs_to :category
    belongs_to :subcategory
    acts_as_taggable
    acts_as_taggable_on :tags

    validates_presence_of :title, :content
    validates_uniqueness_of :title

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
  			content: self.content,
        content_truncate: self.content.truncate(1000),
  			public: self.public ? "Publicado" : "Despublicado",
  			created_at: self.created_at.strftime("%b. %Y"),
        day: self.created_at.day,
  			updated_at: self.updated_at,
        category: Category.find(self.category_id),
        subcategory: self.subcategory.nil? ? nil : Subcategory.find(self.subcategory_id),
        permalink: self.permalink
  		}
  	end

    def create_permalink
      self.permalink = self.title.downcase.parameterize
    end

  end
end
