class CreateInyxBlogRailsPosts < ActiveRecord::Migration
  def change
    create_table :inyx_blog_rails_posts do |t|
      t.string :title
      t.string :autor
      t.text :content
      t.string :image
      t.boolean :public
      t.boolean :comments_open
      t.boolean :likes_enabled
      t.boolean :shared_enabled

      t.timestamps
    end
  end
end
