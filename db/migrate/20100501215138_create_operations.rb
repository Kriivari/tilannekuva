class CreateOperations < ActiveRecord::Migration
  def self.up
    create_table :operations do |t|
      t.string :name
      t.string :latitude
      t.string :longitude
      t.string :zoom
      t.string :width
      t.string :height
      t.string :postfix
      t.boolean :current
      t.string :smsurl
      t.string :tetraport
      t.string :map
      t.timestamps
    end
  end

  def self.down
    drop_table :operations
  end
end
