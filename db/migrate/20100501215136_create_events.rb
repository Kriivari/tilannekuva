class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.boolean :from_hq
      t.string :message
      t.timestamp :archived
      t.references :code
      t.references :location
      t.references :state
      t.references :unit
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
