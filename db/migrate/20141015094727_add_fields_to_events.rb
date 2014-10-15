class AddFieldsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :event_time, :string
    add_column :events, :time_zone, :string
  end
end
