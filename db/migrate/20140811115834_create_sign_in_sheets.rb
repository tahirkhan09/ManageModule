class CreateSignInSheets < ActiveRecord::Migration
  def change
    create_table :sign_in_sheets do |t|
      t.string :non_profiled_attendee
      t.string :prescribing_attendee
      t.string :client_employee_attendee
      t.string :speaker
      t.references :event
      t.timestamps
    end
  end
end
