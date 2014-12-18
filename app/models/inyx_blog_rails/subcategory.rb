module InyxBlogRails
  class Subcategory < ActiveRecord::Base
  	before_save :create_permalink
  	belongs_to :category
  	has_many :posts

  	def self.get_category_id(permalink)
	  	Subcategory.find_by_permalink(permalink).category_id
	  end

	  def self.get_id(permalink)
	  	Subcategory.find_by_permalink(permalink).id
	  end

  	private
	  	def create_permalink
	      self.permalink = self.name.downcase.parameterize
	    end
  end
end
