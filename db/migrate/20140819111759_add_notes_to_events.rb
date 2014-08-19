class AddNotesToEvents < ActiveRecord::Migration
  def change
    add_column :events, :compliance_notes, :string
  end
end
