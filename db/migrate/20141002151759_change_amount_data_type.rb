class ChangeAmountDataType < ActiveRecord::Migration
  def up
    change_column :expenses, :amount, 'float USING CAST(amount AS float)'
  end
end
