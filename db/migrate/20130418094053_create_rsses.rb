class CreateRsses < ActiveRecord::Migration
  def change
    create_table :rsses do |t|
      t.string :name
      t.string :url
      t.integer :deleted

      t.timestamps
    end
  end
end
