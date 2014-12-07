module InyxBlogRails
  class Category < ActiveRecord::Base
  	has_many :posts, dependent: :destroy
  	has_many :subcategories
  	accepts_nested_attributes_for :subcategories, :reject_if => :all_blank, :allow_destroy => true
  end
end
