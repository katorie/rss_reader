class AddFeedsToAuthor < ActiveRecord::Migration
  def change
    add_column :feeds, :author, :string
  end
end
