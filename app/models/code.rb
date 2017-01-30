class Code < ActiveRecord::Base
  has_many :events

  scope :list, -> { order( 'code' ) }

  def to_s
    return self.code
  end

  def formtext
    if self.explanation == nil
      return self.code
    else
      return self.code + " " + self.explanation
    end
  end
end
