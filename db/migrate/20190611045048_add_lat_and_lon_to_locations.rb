class AddLatAndLonToLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :lat, :numeric
    add_column :locations, :lon, :numeric
  end
end
