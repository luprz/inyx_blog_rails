require_dependency "inyx_blog_rails/application_controller"

module InyxBlogRails
  class PostsController < ApplicationController
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    before_filter :authenticate_user!, except: [:show_front, :index_front, :category_front, :subcategory_front, :tag_front, :autor_front]
    layout :resolve_layout
    load_and_authorize_resource :except => [:index_front, :show_front, :search, :search_posts, :category_front, :subcategory_front, :autor_front, :tag_front]



    def search_posts 
      unless params[:query].blank?
        redirect_to posts_front_search_path(params[:query])
      else
        redirect_to index_front_posts_path
      end
    end

    def search
      @posts = Post.search(Post.query params[:query]).records.where(public: true).order('created_at DESC').limit(5).offset(params[:offset])
      @categories = Category.order(:name).all
      @recents = Post.where(public: true).order("created_at DESC").limit(5)
      respond_to do |format|
        format.html
        format.json { render :json => @posts }
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
      @recents = Post.where(public: true).order("created_at DESC").limit(5)
      @post = Post.where(permalink: params[:title]).first
      @categories = Category.order(:name).all
      respond_to do |format|
        format.html
        format.json { render :json => nil }
      end
    end

    def index_front
      @recents = Post.where(public: true).order("created_at DESC").limit(5)
      @posts = Post.where(public: true).order('created_at DESC').limit(5).offset(params[:offset])
      @categories = Category.order(:name).all
      respond_to do |format|
        format.html
        format.json { render :json => @posts }
      end
    end

    def category_front
      @recents = Post.where(public: true).order("created_at DESC").limit(5)
      @categories = Category.order(:name).all
      @posts = Post.where(category_id: Category.get_id(params[:category_permalink]), public: true).order('created_at DESC').limit(5).offset(params[:offset])
      respond_to do |format|
        format.html
        format.json { render :json => @posts }
      end
    end

    def subcategory_front
      @recents = Post.where(public: true).order("created_at DESC").limit(5)
      category = Category.find_by_permalink(params[:category_permalink])
      subcategory = category.subcategories.find_by_permalink(params[:subcategory_permalink])
      @posts = Post.where(subcategory_id: subcategory.id, public: true).order('created_at DESC').limit(5).offset(params[:offset])
      @categories = Category.order(:name).all
      respond_to do |format|
        format.html
        format.json { render :json => @posts }
      end
    end

    def tag_front
      @recents = Post.where(public: true).order("created_at DESC").limit(5)
      @posts = Post.where(public: true).tagged_with(params[:permalink].gsub("-", " ")).order('created_at DESC');
      @categories = Category.order(:name).limit(5).offset(params[:offset])
      respond_to do |format|
        format.html
        format.json { render :json => @posts }
      end
    end

    def autor_front
      @recents = Post.where(public: true).order("created_at DESC").limit(5)
      @posts = Post.where(user_id: User.get_id(params[:permalink]), public: true).order('created_at DESC').limit(5).offset(params[:offset])
      @categories = Category.order(:name).all
      respond_to do |format|
        format.html
        format.json { render :json => @posts }
      end
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
      @categories = Category.all
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
        @post.__elasticsearch__.index_document
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
 
    private

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
          when "show_front", "index_front", "category_front", "subcategory_front", "tag_front", "autor_front", "search_posts", "search"
            "inyx_blog_rails/frontend/application"
          else 
            "admin/application"
        end
      end

  end
end
