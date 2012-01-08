class CreateStates < ActiveRecord::Migration
  def self.up
    create_table :states do |t|
      t.string :state
      t.string :explanation
      t.timestamps
    end

    State.create :state => "Vapaa", :explanation => "Käytettävissä ja alueella"
    State.create :state => "Matkalla", :explanation => "Matkalla kohteeseen"
    State.create :state => "Kohteessa", :explanation => "Kohteessa, ei välttämättä potilaan luona"
    State.create :state => "Potilaan luona", :explanation => "Potilas varmasti tavoitettu"
    State.create :state => "Kuljettaa", :explanation => "Kuljettaa potilasta hoitopaikkaan"
    State.create :state => "Perillä", :explanation => "Perillä hoitopaikassa"
    State.create :state => "Palaa", :explanation => "Palaamassa alueelleen"
    State.create :state => "Tauolla", :explanation => "Tauolla"
    State.create :state => "Ei käytettävissä", :explanation => "Väliaikaisesti poissa vahvuudesta"
  end

  def self.down
    drop_table :states
  end
end
