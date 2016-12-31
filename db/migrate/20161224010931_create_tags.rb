class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
    end

    create_table :tags_tickets, id: false do |t|
      t.integer :tag_id, :ticket_id
    end

    add_index :tags, :name, unique: true
    add_index :tags_tickets, [:tag_id, :ticket_id], unique: true
  end
end
