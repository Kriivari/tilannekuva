class Location < ActiveRecord::Base
  belongs_to :type
  has_many :units
  has_many :events

  def to_s
    return self.location
  end

  def short
    if self.shortcode && self.shortcode.length > 0
      return self.shortcode
    else
      return self.location.to_s[0,10]
    end
  end

  def formtext
    if self.shortcode == nil
      return self.location
    else
      return self.shortcode + " " + self.location
    end
  end
end
