class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|
      t.string :title
      t.string :url
      t.integer :app_store
      t.string :image
      t.text :description
      t.integer :deleted
      t.integer :priority

      t.timestamps
    end
  end
end
