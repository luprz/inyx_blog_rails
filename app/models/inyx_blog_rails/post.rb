module InyxBlogRails
  require 'elasticsearch/model'
  class Post < ActiveRecord::Base
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    before_save :create_permalink
    mount_uploader :image, ImageUploader
    belongs_to :user
    belongs_to :category
    belongs_to :subcategory
    acts_as_taggable
    acts_as_taggable_on :tags

    validates_presence_of :title, :content, :category
    validates_uniqueness_of :title

  	def as_json(options={})
  		{
  			id: self.id,
  			title: self.title,
        title_truncate: self.title.truncate(80),
        image: self.image.url,
  			autor: self.user.name,
        autor_permalink: self.user.permalink,
        autor_id: self.user.id,
        category_name: self.category.nil? ? nil : self.category.name.humanize,
        category_id: self.category_id,
        category_permalink: self.category.nil? ? nil : self.category.permalink,
        subcategory_name: self.subcategory.nil? ? nil : self.subcategory.name,
        subcategory_id: self.subcategory_id,
        subcategory_permalink: self.subcategory.nil? ? nil : self.subcategory.permalink,
        tags: self.tag_list.to_s,
  			content: self.content,
        content_truncate: self.content.truncate(1000),
  			public: self.public ? "Publicado" : "Despublicado",
        publicate: self.public,
        comments_open: self.comments_open,
        likes_enabled: self.likes_enabled,
        shared_enabled: self.shared_enabled,
        datetime: self.created_at? ? self.created_at.strftime("%d %b. %Y / %H:%M") : nil,
  			created_at: self.created_at? ? self.created_at.strftime("%b. %Y") : nil,
        day: self.created_at? ? self.created_at.day : nil,
  			updated_at: self.updated_at? ? self.updated_at : nil,
        category: self.category_id.blank? ? nil : Category.find(self.category_id),
        subcategory: self.subcategory.nil? ? nil : Subcategory.find(self.subcategory_id),
        permalink: self.permalink
  		}
  	end

    def create_permalink
      self.permalink = self.title.downcase.parameterize
    end

    def self.query(query)
      { query: { multi_match:  { query: query, fields: [:title, :category_name, :public, :content, :autor, :subcategory_name, :tags] }  }, sort: { id: "desc" }, size: 10 }
    end
    
  end

  Post.import
end
