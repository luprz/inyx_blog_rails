class CreateInyxBlogRailsSubcategories < ActiveRecord::Migration
  def change
    create_table :inyx_blog_rails_subcategories do |t|
      t.string :name
      t.string :permalink
      t.integer :category_id

      t.timestamps
    end
  end
end
