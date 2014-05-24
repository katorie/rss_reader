class AddPostedAtToItem < ActiveRecord::Migration
  def change
    add_column :items, :posted_at, :datetime
  end
end
