class Operation < ActiveRecord::Base
  scope :active, -> { where current: true }
end
