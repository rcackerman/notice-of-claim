class NoticesController < ApplicationController
  before_action :set_notice, only: [:show, :edit, :update, :pdf]
  #before_action :set_notice, only: [:show, :edit, :update, :destroy]

  # GET /notices
  # GET /notices.json
  def index
    @notices = Notice.all
  end

  # GET /notices/1
  # GET /notices/1.json
  def show
  end

  # GET /notices/new
  def new
    @notice = Notice.new
    @notice.build_physical_injury
    @notice.build_searched_object
  end

  # GET /notices/1/edit
  def edit
  end

  # POST /notices
  # POST /notices.json
  def create
    @notice = Notice.new(notice_params)

    respond_to do |format|
      if @notice.save
        format.html { redirect_to @notice, notice: 'Notice was successfully created.' }
        format.json { render :show, status: :created, location: @notice }
      else
        format.html { render :new }
        format.json { render json: @notice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notices/1
  # PATCH/PUT /notices/1.json
  def update
    respond_to do |format|
      if @notice.update(notice_params)
        format.html { redirect_to @notice, notice: 'Notice was successfully updated.' }
        format.json { render :show, status: :ok, location: @notice }
      else
        format.html { render :edit }
        format.json { render json: @notice.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET
  def pdf
    respond_to do |format|
      format.html
      format.pdf do
        pdf = NoticePDF.new(@notice)
        send_data pdf.render,
                  filename: "#{@notice.name}.pdf",
                  disposition: :inline
      end
    end
    
  end

  # DELETE /notices/1
  # DELETE /notices/1.json
  #def destroy
    #@notice.destroy
    #respond_to do |format|
      #format.html { redirect_to notices_url, notice: 'Notice was successfully destroyed.' }
      #format.json { head :no_content }
    #end
  #end

  def generate_incident_details
    officers = generate_officers(names_only = true)
    details = []

    if @notice.officer_arrested_no_probable_cause == true
      details << "Claimant was subjected to false arrest and false imprisonment by NYPD officers #{officers}."
    end

    if @notice.officer_injured_me == true
      details << "Claimant suffered a battery and was subjected to excessive force #{generate_injury_details} at the hands of NYPD officers #{officers}."
    end

    if @notice.officer_threatened_injury == true
      details << "Claimant was subjected to an assault by NYPD officers #{officers}."
    end

    if @notice.officer_searched == true
      objects = generate_searched_objects
      details << "Claimant was subjected to an illegal search of their property when NYPD officers #{officers} searched their #{objects}."
    end

    if @notice.officer_took_property == true || @notice.officer_damaged_property == true || @notice.officer_destroyed_property == true
      if @notice.officer_took_property == true and @notice.officer_damaged_property != true
        damage = "seized"
      elsif @notice.officer_took_property != false and @notice.officer_damaged_property == true
        damage = "damaged"
      else
        damage = "both seized and damaged"
      end
      details << "Claimant’s property, to wit #{generate_other_objects}, was #{damage} by NYPD officers #{officers}. As a result, claimant was subjected to [Any property claims that apply]."
    end

    details = details.join(' ')
  end


  def generate_officers names_only
    @officers = @notice.officers
    if @officers.any?
      names = @officers.map { |o| o.name }

      unless names_only 
        names = names.map { |o| "Officer #{o}"}
      end

      officer_text = names.join(", ")

    else
      officer_text = names_only ? "John Doe" : "Officer John Doe"
    end
    
    officer_text
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

      details = "by being #{details.join(', ')}"
    else
      details = ""
    end

    details
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

      objects.join(", ")
    else
      objects = ""
    end

    objects
  end

  def generate_other_objects
    # for seized or damaged property
    objects = [@notice.officer_took_what,
                @notice.officer_damaged_what,
                @notice.officer_destroyed_what].uniq.compact
    objects.join(", ")
    objects
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notice
      @notice = Notice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def notice_params
      params.require(:notice).permit(:name,
                                   :address, :incident_description,
                                   :incident_location, :incident_occurred_at,
                                   :officer_injured_me,
                                   {physical_injury_attributes: [
                                    :beaten_with_object,
                                    :hit_by_police_vehicle,
                                    :choked,
                                    :pepper_sprayed,
                                    :tasered,
                                    :attacked_by_police_animal,
                                    :physical_force,
                                    :handcuffs_too_tight,
                                    :other,
                                    :other_description 
                                   ]},
                                   :officer_threatened_injury, :officer_searched,
                                   {:searched_object_attributes => [:vehicle, :bag, :pockets,
                                                         :home, :other]},
                                   :officer_took_property, :officer_took_what,
                                   :officer_damaged_property, :officer_damaged_what,
                                   :officer_destroyed_property, :officer_destroyed_what,
                                   :officer_arrested_no_probable_cause,
                                   :officer_refused_medical_attention,
                                   :none_of_the_above,
                                   :number_officers, {:officers_attributes => [:name, :badge_number]},
                                   :damages_physical_pain, :damages_medical_attention,
                                   :damages_miss_work, :damages_embarrassment,
                                   :damages_emotional_distress, :damages_property)
    end

end
