class Smstoken < ActiveRecord::Migration
  def change
    add_column :operations, :smstoken, :string
    add_column :operations, :smsfrom, :string
  end
end
