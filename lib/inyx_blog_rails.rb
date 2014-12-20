require "inyx_blog_rails/engine"

module InyxBlogRails
	DROPDOWN = [{'blog' => ['<i class="fa fa-book"></i> Blog', 'posts', 'categories']}, { 'posts'=> "/blog/posts", 'categories' => "/posts/categories" }]

	# true/false si desea que se autentiquen los usuarios para poder usar el modulo en el frontend
  mattr_accessor :widget_twitter_id

  # Default way to setup ContactUs. Run rake contact_us:install to create
  # a fresh initializer with all configuration values.
  def self.setup
    yield self
  end
end
