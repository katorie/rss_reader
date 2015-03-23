class ChangeColumnTimestamps < ActiveRecord::Migration
  def up
    change_column_null :feeds, :created_at, false
    change_column_null :feeds, :updated_at, false

    change_column_null :items, :created_at, false
    change_column_null :items, :updated_at, false

    change_column_null :users, :created_at, false
    change_column_null :users, :updated_at, false
  end

  def down
    change_column_null :feeds, :created_at, true
    change_column_null :feeds, :updated_at, true

    change_column_null :items, :created_at, true
    change_column_null :items, :updated_at, true

    change_column_null :users, :created_at, true
    change_column_null :users, :updated_at, true
  end
end
