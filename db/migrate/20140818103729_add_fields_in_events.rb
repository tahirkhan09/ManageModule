class AddFieldsInEvents < ActiveRecord::Migration
  def change
    add_column :events, :av_notes, :string
    add_column :events, :venue_notes, :string
    add_column :events, :final_gurantee, :string
    add_column :events, :venue_address, :string
    add_column :events, :final_gurantee_count, :string
    add_column :events, :venue_contact_name, :string
    add_column :events, :venue_name, :string
    add_column :events, :venue_contact, :string
  end
end
