class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :device_token
      t.string :name
      t.integer :height
      t.string :work
      t.integer :age
      t.string :url
      t.text :message

      t.timestamps
    end
  end
end
