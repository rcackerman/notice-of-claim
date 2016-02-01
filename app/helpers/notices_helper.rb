module NoticesHelper
  include ApplicationHelper
  #def generate_officers number_officers, officers_list, name_only=false
  def generate_officers notice, name_only=false
    number_officers = notice.number_officers || 0
    officers_list = notice.officers || Array.new

    if number_officers == 0
      officers_text = "unknown officer(s)"
    else 
      officers = officers_list.map { |o| o.name }
      pad_by = number_officers - officers_list.length
      officers = pad(pad_by, officers, "John Doe")
      officers_text = name_only ? officers.to_sentence : officers.map { |o| "officer #{o}" }.to_sentence
    end

    officers_text
  end

  def pick_if_seized_damaged notice
    taken = notice.officer_took_property || false
    damaged = notice.officer_damaged_property || false

    if taken and !damaged
      damage = "seized"
    elsif !taken and damaged
      damage = "damaged"
    else
      damage = "both seized and damaged"
    end

    damage
  end

  def generate_injury_details model_trues
    details = Array.new
    model_trues.each do |k, v|
      details << v.downcase
    end
    
    return "by being #{details.to_sentence}"
  end

  def generate_searched_objects model_trues
    objects = Array.new
    model_trues.each do |k, v|
      objects << v.downcase
    end
    objects.to_sentence
  end

  def generate_lost_objects notice
    # for seized or damaged property
    objects = [notice.officer_took_what,
                notice.officer_damaged_what,
                notice.officer_destroyed_what].uniq.compact
    objects.to_sentence
  end

  private

  def pad(by, in_list, text)
    out_list = in_list || Array.new
    by.times { out_list << text }
    out_list
  end
end
