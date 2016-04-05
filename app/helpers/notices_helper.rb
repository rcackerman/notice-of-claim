module NoticesHelper
  include ApplicationHelper
  #def generate_officers number_officers, officers_list, name_only=false
  def generate_officers notice, name_only=false
    number_officers = notice.number_officers || 0
    officers_list = notice.officers || Array.new

    if number_officers == 0
      officers_text = ["unknown officer(s)"]
    else 
      officers = officers_list.map { |o| o.name }
      pad_by = number_officers - officers_list.length
      officers = pad(pad_by, officers, "John Doe")
      officers_text = name_only ? officers : officers.map { |o| "officer #{o}" }
    end

    officers_text
  end

  def generate_notice_claims notice
    claims = Array.new
    officers_list = generate_officers(notice).map{
                        |o| o.titleize
                    }.to_sentence
    injury_detail = notice.physical_injury ? generate_injury_details(notice.physical_injury) :  ""
    search_detail = notice.searched_object ? generate_searched_objects(notice.searched_object) :  ""

    if notice.officer_arrested_no_probable_cause == true
      claims << "Claimant was subjected to false arrest and false imprisonment by NYPD officers #{officers_list}."
    end
    if notice.officer_injured_me == true
      claims << "Claimant suffered a battery and was subjected to excessive force #{injury_detail} at the hands of NYPD officers #{officers_list}."
    end
    if notice.officer_threatened_injury == true
      claims << "Claimant was subjected to an assault by NYPD officers #{officers_list}."
    end
    if notice.officer_searched == true
      claims << "Claimant was subjected to an illegal search of their property when NYPD officers #{officers_list} searched their #{search_detail}."
    end
    if notice.officer_took_property == true || notice.officer_damaged_property == true || notice.officer_destroyed_property == true
      claims << "Claimant’s property, to wit #{generate_lost_objects notice}, was #{pick_if_seized_damaged notice} by NYPD officers #{officers_list}. As a result, claimant was subjected to #{pick_property_claim_type notice}."
    end

    claims.join " "
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

  def generate_injury_details object
    model_trues = filter_trues(object).except(:other)

    details = Array.new
    model_trues.each do |k, v|
      details << v.downcase
    end

    details << object.other_description if !object.other_description.blank?
    
    return "by being #{details.to_sentence}"
  end

  def generate_searched_objects object
    model_trues = filter_trues(object).except(:other)

    objects = Array.new
    model_trues.each do |k, v|
      objects << v.downcase
    end

    objects << object.other_details if !object.other_details.blank?
    objects.to_sentence
  end

  def generate_lost_objects notice
    # for seized or damaged property
    objects = [notice.officer_took_what,
                notice.officer_damaged_what,
                notice.officer_destroyed_what].uniq.compact
    objects = objects.reject { |o| o.empty? }
    objects.to_sentence
  end

  def pick_property_claim_type notice
    claims = Array.new
    if notice.officer_took_property
      claims << "unlawful seizure and conversion"
    end
    if notice.officer_damaged_property
      claims << "trespass to chattels"
    end
    if notice.officer_destroyed_property
      claims << "conversion"
    end

    claims.to_sentence
  end

  def generate_injury_claims notice
    damages = filter_claims(filter_trues(notice), "damages")
    damages_text = Array.new
    if damages.include? :damages_physical_pain
      damages_text << "physical"
    end
    if damages.include? :damages_emotional_distress or damages.include? :damages_embarrassment
      damages_text << "emotional, mental, and psychological injury, pain and suffering"
    end
    if damages.include? :damages_medical_attention
      damages_text << "actual medical expenses"
    end
    if damages.include? :damages_embarrassment
      damages_text << "embarrassment and humiliation"
    end

    damages_text.to_sentence
  end

  def generate_monetary_claims notice
    damages = filter_claims(filter_trues(notice), "damages")
    damages_text = Array.new
    if damages.include? :damages_medical_attention
      damages_text << "medical bills"
      damages_text << "doctor bills"
    end
    if damages.include? :damages_miss_work
      damages_text << "lost earnings"
    end
    if damages.include? :damages_property
      damages_text << "damages to personal property"
    end
    if damages.include? :damages_emotional_distress or damages.include? :damages_embarrassment
      damages_text << "damages for pain and suffering"
    end

    damages_text.join(", ")
    # there's an "and" after this generated text, so use join only
  end

  private

  def pad(by, in_list, text)
    out_list = in_list || Array.new
    by.times { out_list << text }
    out_list
  end

  def filter_claims(hash, to_match)
    claims = hash.keys.select { |key| key.to_s.match(/^#{to_match}.+/) }
    claims
  end
end
