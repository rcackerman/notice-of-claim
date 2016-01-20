class NoticesController < ApplicationController
  #include NoticeLetter
  before_action :set_notice, only: [:show, :edit, :update, :notice, :verification]
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
    3.times { @notice.officers.build }
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
  def notice 
    #notice_text_generator = NoticeLetter::NoticeTextCreator.new(@notice)
    #injuries = 
    respond_to do |format|
      format.html { render :notice }
      format.docx { render :notice }
    end
  end

  def verification
    respond_to do |format|
      format.html { render :verification }
      format.docx { render :verification }
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
                                   :damages_emotional_distress, :damages_property,
                                   :incident_occurred_at_date, :incident_occurred_at_time)
    end

end
