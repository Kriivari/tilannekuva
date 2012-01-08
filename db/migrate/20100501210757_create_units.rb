class CreateUnits < ActiveRecord::Migration
  def self.up
    create_table :units do |t|
      t.string :unit
      t.integer :listorder, :default => 1
      t.string :phone
      t.string :details
      t.references :location
      t.references :state

      t.timestamps
    end

    Unit.create :unit => "Jono", :listorder => 0
    Unit.create :unit => "Johto", :listorder => 2
    Unit.create :unit => "R199", :listorder => -1
    Unit.create :unit => "Tapiola", :listorder => -1
    Unit.create :unit => "Länsi-Helsinki", :listorder => -1
    Unit.create :unit => "Itä-Helsinki", :listorder => -1
    Unit.create :unit => "Länsi-Vantaa", :listorder => -1
    Unit.create :unit => "Kontula", :listorder => -1
    Unit.create :unit => "Porvoo", :listorder => -1
    Unit.create :unit => "Vihti", :listorder => -1
    Unit.create :unit => "Snellu", :listorder => -1
    Unit.create :unit => "Mellunkylä", :listorder => -1
    Unit.create :unit => "Lasse", :listorder => -1
    Unit.create :unit => "Rauta", :listorder => -1
    Unit.create :unit => "Kaivo", :listorder => -1
    Unit.create :unit => "Senaatti", :listorder => -1
    Unit.create :unit => "Espa", :listorder => -1
    Unit.create :unit => "Vaste", :listorder => -1
    Unit.create :unit => "Partio 1", :listorder => -1
    Unit.create :unit => "Partio 2", :listorder => -1
    Unit.create :unit => "Partio 3", :listorder => -1
    Unit.create :unit => "Partio 4", :listorder => -1
    Unit.create :unit => "Partio 5", :listorder => -1
    Unit.create :unit => "Partio 6", :listorder => -1
    Unit.create :unit => "Partio 7", :listorder => -1
    Unit.create :unit => "Partio 8", :listorder => -1
    Unit.create :unit => "Partio 9", :listorder => -1
    Unit.create :unit => "Huone", :listorder => -1
    Unit.create :unit => "Huoneen vaste", :listorder => -1
    Unit.create :unit => "Nolla", :listorder => -1
  end

  def self.down
    drop_table :units
  end
end
