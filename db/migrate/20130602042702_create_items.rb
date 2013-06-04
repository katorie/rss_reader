class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.text :body
      t.text :url
      t.integer :feed_id

      t.timestamps
    end
  end
end
