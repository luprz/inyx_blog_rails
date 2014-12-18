module InyxBlogRails
  class Category < ActiveRecord::Base
  	before_save :humanize_name, :create_permalink
    validates_uniqueness_of :name
  	has_many :posts, dependent: :destroy
  	has_many :subcategories
  	accepts_nested_attributes_for :subcategories, :reject_if => :all_blank, :allow_destroy => true

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
  end
end
