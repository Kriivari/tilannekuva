class Operations < ActiveRecord::Migration
  def change
    add_reference :events, :operation, foreign_key: true
  end
end
