require_dependency "inyx_blog_rails/application_controller"

module InyxBlogRails
  class AngularController < ApplicationController

  	def post
  		post = Post.find(params[:id])
  		respond_to do |format|
        format.html
        format.json { render :json => post.as_json }
      end
  	end

    def subcategories
    	subcategories = Subcategory.where(category_id: params[:id])
    	respond_to do |format|
        format.html
        format.json { render :json => subcategories  }
      end
    end

  end
end
