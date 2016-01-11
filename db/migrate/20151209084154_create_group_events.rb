class CreateGroupEvents < ActiveRecord::Migration
  def change
    create_table :group_events do |t|
      t.date :event_start
      t.date :event_end
      t.integer :event_duration
      t.string :name
      t.text :description
      t.string :location
      t.boolean :published, default: false
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
