require 'rails_helper'

RSpec.describe NoticesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Notice. As you add validations to Notice, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    { name: "Jane Doe",
      address: "Test Address",
      incident_location: "123 Test Street",
      incident_occurred_at: Time.now.to_s(:db)
    }
  }

  let(:invalid_attributes) {
    { crazyglue: "Nope" }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # NoticesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all notices as @notices" do
      #notice = Notice.create! valid_attributes
      #get :index, {}, valid_session
      skip("Database isn't cleaning up")
      #expect(assigns(:notices)).to eq([notice])
    end
  end

  describe "GET #show" do
    it "assigns the requested notice as @notice" do
      #notice = Notice.create! valid_attributes
      #get :show, {:id => notice.to_param}, valid_session
      #expect(assigns(:notice)).to eq(notice)
      skip("Database isn't cleaning up")
    end
  end

  describe "GET #new" do
    it "assigns a new notice as @notice" do
      get :new, {}, valid_session
      expect(assigns(:notice)).to be_a_new(Notice)
    end
  end

  describe "GET #edit" do
    it "assigns the requested notice as @notice" do
      notice = Notice.create! valid_attributes
      get :edit, {:id => notice.to_param}, valid_session
      expect(assigns(:notice)).to eq(notice)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Notice" do
        expect {
          post :create, {:notice => valid_attributes}, valid_session
        }.to change(Notice, :count).by(1)
      end

      it "assigns a newly created notice as @notice" do
        post :create, {:notice => valid_attributes}, valid_session
        expect(assigns(:notice)).to be_a(Notice)
        expect(assigns(:notice)).to be_persisted
      end

      it "redirects to the created notice" do
        post :create, {:notice => valid_attributes}, valid_session
        expect(response).to redirect_to(Notice.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved notice as @notice" do
        post :create, {:notice => invalid_attributes}, valid_session
        expect(assigns(:notice)).to be_a_new(Notice)
      end

      it "re-renders the 'new' template" do
        post :create, {:notice => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let!(:notice) { FactoryGirl.create(:notice_with_officers, number_officers: 2, officers_count: 2) }


      it "updates the requested notice" do
        new_attributes = { name: "Jane Doe v2",
                           address: "Test Address",
                           incident_location: "123 Test Street",
                           incident_occurred_at: Time.now.to_s(:db),
                           :officer_attributes => { "0" => {id: notice.officers[0].id, name: "Bob 1000", badge_number: "15AC"},
                                                    "1" => {id: notice.officers[1].id, name: notice.officers[1].name, badge_number: notice.officers[1].badge_number}
                                                  }
                         }
        put :update, {:id => notice.to_param, :notice => new_attributes}, valid_session
        notice.reload
        expect(notice.name).to eq("Jane Doe v2")
      end

      it "assigns the requested notice as @notice" do
        notice = Notice.create! valid_attributes
        put :update, {:id => notice.to_param, :notice => valid_attributes}, valid_session
        expect(assigns(:notice)).to eq(notice)
      end

      it "redirects to the notice" do
        notice = Notice.create! valid_attributes
        put :update, {:id => notice.to_param, :notice => valid_attributes}, valid_session
        expect(response).to redirect_to(notice)
      end
    end

    context "with invalid params" do
      it "assigns the notice as @notice" do
        notice = Notice.create! valid_attributes
        put :update, {:id => notice.to_param, :notice => invalid_attributes}, valid_session
        expect(assigns(:notice)).to eq(notice)
      end

      it "re-renders the 'edit' template" do
        notice = Notice.create! valid_attributes
        put :update, {:id => notice.to_param, :notice => invalid_attributes}, valid_session
        expect(response).to render_template(:edit)
      end
    end
  end

  #describe "DELETE #destroy" do
    #it "destroys the requested notice" do
      #binding.pry
      #notice = Notice.create! valid_attributes
      #expect {
        #delete :destroy, {:id => notice.to_param}, valid_session
      #}.to change(Notice, :count).by(-1)
    #end

    #it "redirects to the notices list" do
      #notice = Notice.create! valid_attributes
      #delete :destroy, {:id => notice.to_param}, valid_session
      #expect(response).to redirect_to(notices_url)
    #end
  #end

end
