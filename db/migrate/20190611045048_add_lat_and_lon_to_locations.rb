class AddLatAndLonToLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :lat, :double
    add_column :locations, :lon, :double
  end
end
