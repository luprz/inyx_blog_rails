class UpdateTablePost < ActiveRecord::Migration
  def change
  	remove_column :inyx_blog_rails_posts, :autor
    add_column :inyx_blog_rails_posts, :user_id, :integer
  end
end
