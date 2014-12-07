class CreateInyxBlogRailsCategories < ActiveRecord::Migration
  def change
    create_table :inyx_blog_rails_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
