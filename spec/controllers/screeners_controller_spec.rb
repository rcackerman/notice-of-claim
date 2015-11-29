require 'rails_helper'

RSpec.describe ScreenersController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Screener. As you add validations to Screener, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {:harmed_mistreated => true, :incident_occurred_on => Date.today}
  }

  let(:invalid_attributes) {
    skip("Nothing yet")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ScreenersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  let(:screened_in_attributes) {
    {:harmed_mistreated => true, :incident_occurred_on => Date.today}
  }

  let(:screened_out_attributes) {
    {:harmed_mistreated => false, :incident_occurred_on => Date.today}
  }

  describe "#screen_claim" do
    context "user was harmed by NYPD" do
      context "and it happened within 90 days" do
        it "screens in" do
          incident_date = (Date.today - 80).to_s
          result = controller.screen_claim(true, incident_date)
          expect(result).to be true
        end
      end

      context "and it happened 90 days ago" do
        it "screens in" do
          incident_date = (Date.today - 90).to_s
          result = controller.screen_claim(true, incident_date)
          expect(result).to be true
        end
      end

      context "and it happened more than 90 days ago" do
        it "screens out" do
          incident_date = (Date.today - 91).to_s
          result = controller.screen_claim(true, incident_date)
          expect(result).to be false
        end
      end
    end
    # end user was harmed by NYPD

    context "user was not harmed by NYPD" do
      context "and it happened within 90 days" do
        it "screens out" do
          incident_date = (Date.today - 80).to_s
          result = controller.screen_claim(false, incident_date)
          expect(result).to be false
        end
      end
      context "and it happened 90 days ago" do
        it "screens out" do
          incident_date = (Date.today - 90).to_s
          result = controller.screen_claim(false, incident_date)
          expect(result).to be false
        end
      end
      context "and it happened more than 90 days ago" do
        it "screens out" do
          incident_date = (Date.today - 91).to_s
          result = controller.screen_claim(false, incident_date)
          expect(result).to be false
        end
      end
    end
    # end user was not harmed by NYPD
  end
  # end #screen_claim

  describe "GET #index" do
    it "assigns all screeners as @screeners" do
      screener = Screener.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:screeners)).to eq([screener])
    end
  end

  describe "GET #show" do
    it "assigns the requested screener as @screener" do
      screener = Screener.create! valid_attributes
      get :show, {:id => screener.to_param}, valid_session
      expect(assigns(:screener)).to eq(screener)
    end
  end

  describe "GET #new" do
    it "assigns a new screener as @screener" do
      get :new, {}, valid_session
      expect(assigns(:screener)).to be_a_new(Screener)
    end
  end

  describe "GET #edit" do
    it "assigns the requested screener as @screener" do
      screener = Screener.create! valid_attributes
      get :edit, {:id => screener.to_param}, valid_session
      expect(assigns(:screener)).to eq(screener)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Screener" do
        expect {
          post :create, {:screener => valid_attributes}, valid_session
        }.to change(Screener, :count).by(1)
      end

      it "assigns a newly created screener as @screener" do
        post :create, {:screener => valid_attributes}, valid_session
        expect(assigns(:screener)).to be_a(Screener)
        expect(assigns(:screener)).to be_persisted
      end

      context "and screened in" do
        it "redirects to a new notice form" do
          post :create, {:screener => valid_attributes}, valid_session
          expect(response).to redirect_to(new_notice_url)
        end
      end

      context "and screened out" do
        skip("No static pages controller yet")
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved screener as @screener" do
        post :create, {:screener => invalid_attributes}, valid_session
        expect(assigns(:screener)).to be_a_new(Screener)
      end

      it "re-renders the 'new' template" do
        post :create, {:screener => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  #describe "PUT #update" do
    #context "with valid params" do
      #let(:new_attributes) {
        #skip("Add a hash of attributes valid for your model")
      #}

      #it "updates the requested screener" do
        #screener = Screener.create! valid_attributes
        #put :update, {:id => screener.to_param, :screener => new_attributes}, valid_session
        #screener.reload
        #skip("Add assertions for updated state")
      #end

      #it "assigns the requested screener as @screener" do
        #screener = Screener.create! valid_attributes
        #put :update, {:id => screener.to_param, :screener => valid_attributes}, valid_session
        #expect(assigns(:screener)).to eq(screener)
      #end

      #it "redirects to the screener" do
        #screener = Screener.create! valid_attributes
        #put :update, {:id => screener.to_param, :screener => valid_attributes}, valid_session
        #expect(response).to redirect_to(screener)
      #end
    #end

    #context "with invalid params" do
      #it "assigns the screener as @screener" do
        #screener = Screener.create! valid_attributes
        #put :update, {:id => screener.to_param, :screener => invalid_attributes}, valid_session
        #expect(assigns(:screener)).to eq(screener)
      #end

      #it "re-renders the 'edit' template" do
        #screener = Screener.create! valid_attributes
        #put :update, {:id => screener.to_param, :screener => invalid_attributes}, valid_session
        #expect(response).to render_template("edit")
      #end
    #end
  #end

  #describe "DELETE #destroy" do
    #it "destroys the requested screener" do
      #screener = Screener.create! valid_attributes
      #expect {
        #delete :destroy, {:id => screener.to_param}, valid_session
      #}.to change(Screener, :count).by(-1)
    #end

    #it "redirects to the screeners list" do
      #screener = Screener.create! valid_attributes
      #delete :destroy, {:id => screener.to_param}, valid_session
      #expect(response).to redirect_to(screeners_url)
    #end
  #end

end
