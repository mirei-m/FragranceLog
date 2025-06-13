class ChangeWeatherAndMoodTypeInCalendars < ActiveRecord::Migration[7.2]
  def change
    change_column :calendars, :weather, 'integer USING weather::integer'
    change_column :calendars, :mood, 'integer USING mood::integer'
  end
end
