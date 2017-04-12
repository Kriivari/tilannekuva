class State < ActiveRecord::Base
  has_many :units
  has_many :events

  def to_s
    return self.state
  end
end
