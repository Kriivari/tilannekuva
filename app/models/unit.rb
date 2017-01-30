class Unit < ActiveRecord::Base
  belongs_to :state, optional: true
  belongs_to :location, optional: true
  has_many :events

  scope :queue, -> { where listorder: 0 }
  scope :list, -> { where( "listorder > -1" ).order( :listorder, :unit ) }
  scope :real, -> { where( "listorder = 1").order(:unit) }
  scope :virtual, -> { where( "listorder < 0 or listorder = 1").order(:unit) }

  def to_s
    self.unit
  end

  def isfree
    if self.state != nil && ( self.state.id == 1 || self.state.id == 7 )
      return self.state.state
    end
    return ""
  end
  def isenroute
    if self.state != nil && self.state.id == 2
      return self.state.state
    end
    return ""
  end
  def isworking
    if self.state != nil && ( self.state.id == 3 || self.state.id == 4 )
      return self.state.state
    end
    return ""
  end
  def istransporting
    if self.state != nil && ( self.state.id == 5 || self.state.id == 6 )
      return self.state.state
    end
    return ""
  end
  def isaway
    if self.state != nil && ( self.state.id == 8 || self.state.id == 9 )
      return self.state.state
    end
    return ""
  end
  def currentcode
    ev = get_current_event
    if ev != nil
      return ev.code
    end
    return nil
  end
  def currentlocation
    ev = get_current_event
    if ev != nil
      return ev.location
    end
    return nil
  end
  def currentmessage
    ev = get_current_event
    if ev != nil
      return ev.message
    end
    return nil
  end
  def currenttime(format)
    ev = get_current_event
    if ev != nil
      return ev.updated_at.strftime(format)
    end
    return ""
  end

  def get_current_event
    events = Event.where(["unit_id=? and archived is null", self.id]).order("updated_at desc")
    if events != nil && events.size > 0
      return events.first
    end
    return nil
  end

  def coloredname
    if self.state != nil && ( self.state.id == 1 || self.state.id == 7 )
      return "<div style='background-color:Lime'>" + self.unit + "</div>"
    end
    if self.state != nil && ( self.state.id == 2 || self.state.id == 3 || self.state.id == 4 || self.state.id == 5 || self.state.id == 6 )
      return "<div style='background-color:Red'>" + self.unit + "</div>"
    end
    return "<div style='background-color:Black; color:White'>" + self.unit + "</div>"
  end
end
