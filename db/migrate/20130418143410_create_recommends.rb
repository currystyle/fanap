class CreateRecommends < ActiveRecord::Migration
  def change
    create_table :recommends do |t|
      t.integer :priority
      t.string :name
      t.string :image
      t.string :link
      t.text :description
      t.integer :deleted

      t.timestamps
    end
  end
end
