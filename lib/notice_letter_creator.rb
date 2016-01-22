  class NoticeTextCreator
    def initialize object
      @notice = object 
    end

    def generate_officers name_only=false
      unless @notice.number_officers.nil?
        number_officers = @notice.number_officers
        
        if @notice.officers.any?
          officers = @notice.officers.map { |o| o.name }
          pad_by = number_officers - officers.length
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

    def generate_incident_details
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
        incident_details << "Claimant’s property, to wit #{generate_other_objects}, was #{damage} by NYPD officers #{officers}. As a result, claimant was subjected to [Any property claims that apply]."
      end

      incident_details.join(" ")
    end

    def generate_injury_details
      unless @notice.physical_injury.nil?
        details = []
        @injury = @notice.physical_injury

        if @injury.beaten_with_object
          details << "beaten with an object"
        end
        if @injury.choked
          details << "choked"
        end
        if @injury.pepper_sprayed
          details << "pepper-sprayed"
        end
        if @injury.tasered
          details << "tasered"
        end
        if @injury.attacked_by_police_animal
          details << "attacked by a police animal"
        end
        if @injury.hit_by_police_vehicle
          details << "hit by police vehicle"
        end
        if @injury.handcuffs_too_tight
          details << "handcuffed too tightly"
        end

        @injury_details = "by being #{details.join(', ')}"
      else
        @injury_details = ""
      end

      @injury_details
    end

    def generate_searched_objects
      unless @notice.searched_object.nil?
        @object = @notice.searched_object
        objects = []

        if @object.vehicle
          objects << "vehicle"
        end
        if @object.bag
          objects << "bag"
        end
        if @object.pockets
          objects << "pockets"
        end
        if @object.home
          objects << "home"
        end
        if @object.other_details
          objects << @object.other_details
        end

        @searched_object_text = objects.join(", ")
      else
        @searched_objects_text = ""
      end
    end

    def generate_other_objects
      # for seized or damaged property
      objects = [@notice.officer_took_what,
                  @notice.officer_damaged_what,
                  @notice.officer_destroyed_what].uniq.compact
      objects.join(", ")
      objects
    end
  end

