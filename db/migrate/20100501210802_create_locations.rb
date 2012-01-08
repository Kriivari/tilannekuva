class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :location
      t.string :shortcode
      t.integer :x
      t.integer :y
      t.references :type
      t.timestamps
    end

    Location.create :location => "Malmin sairaala", :shortcode => "M0"
    Location.create :location => "Haartmanin sairaala", :shortcode => "M1"
    Location.create :location => "Hesperian sairaala", :shortcode => "H0"
    Location.create :location => "Hyrylän sairaala", :shortcode => "T2"
    Location.create :location => "Invalidisäätiö", :shortcode => "I1"
    Location.create :location => "Jorvin sairaala", :shortcode => "M5"
    Location.create :location => "Järvenpään terveyskeskus", :shortcode => "T3"
    Location.create :location => "Kellokosken sairaala", :shortcode => "H1"
    Location.create :location => "Keravan terveyskeskus", :shortcode => "T1"
    Location.create :location => "Kiljava", :shortcode => "R1"
    Location.create :location => "Kirurginen sairaala", :shortcode => "K1"
    Location.create :location => "Kivelän sairaala", :shortcode => "M3"
    Location.create :location => "Korvaklinikka", :shortcode => "A1"
    Location.create :location => "Kätilöopisto", :shortcode => "N1"
    Location.create :location => "Lasten ja nuorten sairaala", :shortcode => "L2"
    Location.create :location => "Meilahden sairaala", :shortcode => "M2"
    Location.create :location => "Naistenklinikka", :shortcode => "N2"
    Location.create :location => "Nurmijärven terveyskeskus", :shortcode => "T4"
    Location.create :location => "Peijaksen sairaala", :shortcode => "M6"
    Location.create :location => "Selviämisasema", :shortcode => "P1"
    Location.create :location => "Riihimäen aluesairaala", :shortcode => "M7"
    Location.create :location => "Silmäklinikka", :shortcode => "A2"
    Location.create :location => "Sädehoito", :shortcode => "S1"
    Location.create :location => "Taivis", :shortcode => "TN"
    Location.create :location => "Töölön sairaala", :shortcode => "K2"
    hoito = Type.where( :name => "Hoitopaikka" ).first
    Location.update_all ["type_id = ?", hoito.id]
    asema = Type.where( :name => "Asemapaikka" ).first
    l = Location.create :location => "Rautatientori", :shortcode => "Rauta"
    l.type = asema
    l.save
    l = Location.create :location => "Senaatintori", :shortcode => "Senaatti"
    l.type = asema
    l.save
    l = Location.create :location => "Kauppatori", :shortcode => "Kauppa"
    l.type = asema
    l.save
    l = Location.create :location => "Esplanaadi", :shortcode => "Espa"
    l.type = asema
    l.save
    l = Location.create :location => "Kaivopuisto", :shortcode => "Kaivo"
    l.type = asema
    l.save
    l = Location.create :location => "Koffin puisto", :shortcode => "Koff"
    l.type = asema
    l.save
    l = Location.create :location => "Hietaniemenranta", :shortcode => "Hietsu"
    l.type = asema
    l.save
  end

  def self.down
    drop_table :locations
  end
end
