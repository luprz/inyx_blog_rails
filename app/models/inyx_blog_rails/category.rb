module InyxBlogRails
  require 'elasticsearch/model'
  class Category < ActiveRecord::Base
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
  	before_save :humanize_name, :create_permalink
    validates_uniqueness_of :name
  	has_many :posts, dependent: :destroy
  	has_many :subcategories
  	accepts_nested_attributes_for :subcategories, :reject_if => :all_blank, :allow_destroy => true

  	 
    def as_json(options={})
      {
        id: self.id,
        name: self.name,
        subcategories: self.subcategories.map { |sub| sub.name }.join(", ")
      }
    end

    def self.query(query)
      { query: { multi_match:  { query: query, fields: [:name, :subcategories] }  }, sort: { id: "desc" }, size: Post.count }
    end

    def self.get_id(permalink)
	  	Category.find_by_permalink(permalink).id
	  end

	  private

	  def humanize_name
	  	self.name = self.name.humanize
	  end

    def create_permalink
      self.permalink = self.name.downcase.parameterize
    end

    def self.index(current_user)
      Category.order('created_at DESC')
    end

    def self.index_search(objects, current_user)
      objects.order('created_at DESC')
    end

    def self.index_total(objects, current_user)
      objects.count
    end

    def self.route_index
      "/admin/posts/categories"
    end

    def self.multiple_destroy(ids, current_user)
      ids.each do |id|
        if !current_user.has_role? :admin
          raise CanCan::AccessDenied.new("Access Denied", :delete, InyxBlogRails::Category)
        end
      end
      Category.destroy ids
    end

  end
  Category.import
end
