class Screener < ActiveRecord::Base
  has_one :notice

  def incident_occurred_on=(date)
     begin
       parsed = Date.strptime(date,'%m/%d/%Y %I:%M %p')
       super parsed
     rescue
       date         
     end
  end
end
