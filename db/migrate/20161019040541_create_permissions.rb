class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.integer :user_id
      t.integer :thing_id
      t.string :action
      t.string :thing_type

      t.timestamps null: false
    end
  end
end
