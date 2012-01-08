class Event < ActiveRecord::Base
  belongs_to :code
  belongs_to :location
  belongs_to :unit
  belongs_to :state

  scope :active, where( :archived => nil )
  scope :transport, where( "archived is null and state_id in (5)" )
  scope :customer, where( "archived is null and state_id in (3,4)" )
end
