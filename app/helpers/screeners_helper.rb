module ScreenersHelper
  def screen_claim(harm, incident_date)
    incident_date = incident_date.to_date
    if harm && (incident_date >= (Date.today - 90))
      return true
    else
      return false
    end
  end
end
