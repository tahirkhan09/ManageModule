class AddLockToEvent < ActiveRecord::Migration
  def change
    add_column :events, :is_lock, :boolean
  end
end
