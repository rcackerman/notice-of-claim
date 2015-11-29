class ScreenersController < ApplicationController
  before_action :set_screener, only: [:show, :edit, :update, :destroy]


  # GET /screeners
  # GET /screeners.json
  def index
    @screeners = Screener.all
  end

  # GET /screeners/1
  # GET /screeners/1.json
  def show
  end

  # GET /screeners/new
  def new
    @screener = Screener.new
  end

  # GET /screeners/1/edit
  def edit
  end

  # POST /screeners
  # POST /screeners.json
  def create
    @screener = Screener.new(screener_params)
    #binding.pry

    respond_to do |format|
      if @screener.save
        harm = params[:screener][:harmed_mistreated]
        incident = params[:screener][:incident_occurred_on]

        if screen_claim(harm, incident) == true
          format.html { redirect_to new_notice_url, notice: 'Screener was successfully created.' }
          #format.json { render :show, status: :created, location: @screener }
        else
          # TODO: redirect to static "sorry" page
          format.html { redirect_to @screener, notice: 'Screener successful but criteria not met.'}
          format.json { render :show, status: :created, location: @screener }
        end
      else
        #binding.pry
        format.html { render :new }
        format.json { render json: @screener.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /screeners/1
  # PATCH/PUT /screeners/1.json
  def update
    respond_to do |format|
      if @screener.update(screener_params)
        format.html { redirect_to @screener, notice: 'Screener was successfully updated.' }
        format.json { render :show, status: :ok, location: @screener }
      else
        format.html { render :edit }
        format.json { render json: @screener.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /screeners/1
  # DELETE /screeners/1.json
  #def destroy
    #@screener.destroy
    #respond_to do |format|
      #format.html { redirect_to screeners_url, notice: 'Screener was successfully destroyed.' }
      #format.json { head :no_content }
    #end
  #end

  def screen_claim(harm, incident_date)
    begin
      incident_date = Date.parse(incident_date)
      if harm && (incident_date >= Date.today - 90)
        return true
      else
        return false
      end
    rescue
      "Something went wrong"
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_screener
      @screener = Screener.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def screener_params
      params.require(:screener).permit(:harmed_mistreated,
                               :incident_occurred_on)
    end

end
