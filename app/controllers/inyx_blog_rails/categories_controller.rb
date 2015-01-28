require_dependency "inyx_blog_rails/application_controller"

module InyxBlogRails
  class CategoriesController < ApplicationController
    before_action :set_category, only: [:show, :edit, :update, :destroy]
    before_filter :authenticate_user!
    load_and_authorize_resource
    layout 'admin/application'

    # GET /categories/1
    def show
    end

    # GET /categories/new
    def new
      @category = Category.new
    end

    # GET /categories/1/edit
    def edit
    end

    # POST /categories
    def create
      @category = Category.new(category_params)

      if @category.save
        redirect_to @category, notice: 'La categoría ha sido creada satisfactoriamente.'
      else
        render :new
      end
    end

    # PATCH/PUT /categories/1
    def update
      if @category.update(category_params)
        @category.__elasticsearch__.index_document
        redirect_to @category, notice: 'La categoría ha sido actualizada satisfactoriamente.'
      else
        render :edit
      end
    end

    # DELETE /categories/1
    def destroy
      @category.destroy
      redirect_to categories_url, notice: 'La categoría ha sido eliminada satisfactoriamente.'
    end


    private
    
      # Use callbacks to share common setup or constraints between actions.
      def set_category
        @category = Category.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def category_params
        params.require(:category).permit(:name, subcategories_attributes: [:id, :name, :_destroy])
      end
  end
end
