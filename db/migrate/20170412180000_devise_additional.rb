class DeviseAdditional < ActiveRecord::Migration
  def change
    add_reference :users, :operation, foreign_key: true
  end
end
