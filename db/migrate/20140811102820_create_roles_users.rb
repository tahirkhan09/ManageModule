class CreateRolesUsers < ActiveRecord::Migration
  def change
    create_table :roles_users do |t|
      t.references :user, new: true
      t.references :role, new: true

      t.timestamps
    end
  end
end
