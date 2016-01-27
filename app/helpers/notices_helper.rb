module NoticesHelper
  def generate_officers number_officers, officers_list, name_only=false
    number_officers = number_officers || 0
    if officers_list.any?
      officers = officers_list.map { |o| o.name }
      pad_by = number_officers - officers_list.length
    else
      pad_by = number_officers
      officers = Array.new
    end

      pad_by.times { officers << "John Doe" }

      @officers_text = name_only ? officers.to_sentence : officers.map { |o| "officer #{o}" }.to_sentence
    else
      @officers_text = "unknown officer(s)"
    end
  end

  def generate_incident_details model_trues
    officers_list = generate_officers
    incident_details = Array.new

    if @notice.officer_arrested_no_probable_cause == true
      incident_details << "Claimant was subjected to false arrest and false imprisonment by NYPD officers #{officers_list.titleize}."
    end

    if @notice.officer_injured_me == true
      incident_details << "Claimant suffered a battery and was subjected to excessive force #{generate_injury_details} at the hands of NYPD officers #{officers_list.titleize}."
    end

    if @notice.officer_threatened_injury == true
      incident_details << "Claimant was subjected to an assault by NYPD officers #{officers_list.titleize}."
    end

    if @notice.officer_searched == true
      objects = generate_searched_objects
      incident_details << "Claimant was subjected to an illegal search of their property when NYPD officers #{officers_list.titleize} searched their #{objects}."
    end

    if @notice.officer_took_property == true || @notice.officer_damaged_property == true || @notice.officer_destroyed_property == true
      if @notice.officer_took_property == true and @notice.officer_damaged_property != true
        damage = "seized"
      elsif @notice.officer_took_property != false and @notice.officer_damaged_property == true
        damage = "damaged"
      else
        damage = "both seized and damaged"
      end
      incident_details << "Claimant’s property, to wit #{generate_other_objects}, was #{damage} by NYPD officers #{officers_list}. As a result, claimant was subjected to [Any property claims that apply]."
    end

    incident_details.join(" ")
  end

  def generate_injury_details notice
    model_trues
      details = Array.new
      model_trues.each do |i|
        details << i
      end
      
      return "by being #{details.to_sentence}"

  end

  def generate_searched_objects model_trues
    objects = Array.new
    model_trues.each do |i|
      objects << i
    end
    objects.to_sentence
end

  def generate_lost_objects
    # for seized or damaged property
    objects = [@notice.officer_took_what,
                @notice.officer_damaged_what,
                @notice.officer_destroyed_what].uniq.compact
    objects.join(", ")
    objects
  end

end
