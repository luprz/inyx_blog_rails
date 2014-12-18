require_dependency "inyx_blog_rails/application_controller"

module InyxBlogRails
  class PostsController < ApplicationController
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    before_filter :authenticate_user!, except: [:show_front, :index_front, :category_front, :subcategory_front, :tag_front, :autor_front]
    layout :resolve_layout


    # GET /posts
    def index
      @posts = Post.all
    end

    def angular_index
      posts = Post.all
      respond_to do |format|
        format.html
        format.json { render :json => posts  }
      end
    end

    # GET /posts/1
    def show
      respond_to do |format|
        format.html
        format.json { render :json => @post.category_form }
      end
    end

    def show_front
      @post = Post.where(permalink: params[:title]).first
    end

    def index_front
      @posts = Post.order('created_at DESC').all
    end

    def category_front
      @subcategories = Subcategory.where(category_id: Category.get_id(params[:category_permalink]))
      @posts = Post.where(category_id: Category.get_id(params[:category_permalink])).order('created_at DESC').all
    end

    def subcategory_front
      category = Category.find_by_permalink(params[:category_permalink])
      subcategory = category.subcategories.find_by_permalink(params[:subcategory_permalink])
      @subcategories = Subcategory.where(category_id: Category.get_id(params[:category_permalink]))
      @posts = Post.where(subcategory_id: subcategory.id).order('created_at DESC').all
    end

    def tag_front
      @posts = Post.tagged_with(params[:permalink].gsub("-", " ")).order('created_at DESC');
    end

    def autor_front
      @posts = Post.where(user_id: params[:permalink]).order('created_at DESC').all
    end

    # GET /posts/new
    def new
      @categories = Category.all
      @post = Post.new
      @subcategories = Category.find(@post.category_id).subcategories if @post.created_at?
    end

    # GET /posts/1/edit
    def edit
      @subcategories = Category.find(@post.category_id).subcategories
      @categories = Category.all
    end

    # POST /posts
    def create
      @post = Post.new(post_params)
      @post.user_id = current_user.id


      if @post.save
        redirect_to @post, notice: 'El post ha sido creado satisfactoriamente.'
      else
        render :new
      end
    end

    # PATCH/PUT /posts/1
    def update
      if @post.update(post_params)
        redirect_to @post, notice: 'El post ha sido actualizado satisfactoriamente.'
      else
        render :edit
      end
    end

    # DELETE /posts/1
    def destroy
      @post.destroy
      redirect_to posts_url, notice: 'El post ha sido eliminado satisfactoriamente.'
    end

    def delete
      Post.destroy( redefine_destroy params[:ids].split(",") )
      respond_to do |format|
        format.html { render nothing: true }
      end
    end

    private
      #metodo para redefinir el array de los elementos selecionados que se van a eliminar
      def redefine_destroy(params)
        params.sort.each do |id|
          params.delete id unless Post.exists? id
        end
      end
      # Use callbacks to share common setup or constraints between actions.
      def set_post
        @post = Post.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def post_params
        params.require(:post).permit(:title, :content, :image, :public, :comments_open, :likes_enabled, :shared_enabled, :tag_list, :category_id, :subcategory_id, :permalink)
      end

      def resolve_layout
        case action_name
          when "show_front", "index_front", "category_front", "subcategory_front", "tag_front", "autor_front"
            "application"
          else 
            "admin/application"
        end
      end

  end
end
