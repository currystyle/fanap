class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :rss_id
      t.string :image_url
      t.string :link
      t.integer :pubdate
      t.string :title
      t.integer :tweet_count
      t.integer :deleted

      t.timestamps
    end
  end
end
