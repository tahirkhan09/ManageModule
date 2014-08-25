class ChangeDefaultLockInEvent < ActiveRecord::Migration
  def change
    change_column :events, :is_lock, :boolean, :default => false
  end
end
