class Code < ActiveRecord::Base
  has_many :events

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
