class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.integer :serial_number
      t.string :expense_type
      t.string :amount
      t.string :value_transfer_date
      t.string :payment_mode
      t.string :notes
      t.string :av_notes
      t.string :venue_notes
      t.references :event

      t.timestamps
    end
  end
end
