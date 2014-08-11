class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :event_id_dlp
      t.string :event_id_smi
      t.string :event_type
      t.string :rep_name
      t.string :speaker_name
      t.string :event_date
      t.string :event_month
      t.string :quarter
      t.string :event_city
      t.string :event_state
      t.string :speaker_city
      t.string :speaker_state
      t.boolean :speaker_travel_required, :default => false
      t.references :user

      t.timestamps
    end
  end
end
