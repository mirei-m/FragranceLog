class CreateCalendars < ActiveRecord::Migration[7.2]
  def change
    create_table :calendars do |t|
      t.datetime :start_time, null: false
      t.string :weather
      t.string :mood
      t.text :memo
      t.references :user, null: false, foreign_key: true
      t.references :fragrance, null: false, foreign_key: true

      t.timestamps
    end
    add_index :calendars, [ :user_id, :start_time ], unique: true
  end
end
