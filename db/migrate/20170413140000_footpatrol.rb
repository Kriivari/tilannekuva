class Footpatrol < ActiveRecord::Migration
  def change
    add_column :units, :car, :boolean
  end
end
