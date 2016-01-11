require 'rails_helper'


RSpec.describe GroupEventsController, type: :controller do

  let(:valid_attributes) {
	{ event_start: Time.now, event_duration: 10 }
  }

  let(:invalid_attributes) {
	{ published: true }
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all group_events as @group_events" do
      group_event = GroupEvent.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:group_events)).to eq([group_event])
    end
  end

  describe "GET #index.json" do
    it "assigns all group_events as @group_events" do
      group_event = GroupEvent.create! valid_attributes
      get :index, format: :json
      expect(assigns(:group_events)).to eq([group_event])
    end
  end

  describe "GET #show" do
    it "assigns the requested group_event as @group_event" do
      group_event = GroupEvent.create! valid_attributes
      get :show, {:id => group_event.to_param}, valid_session
      expect(assigns(:group_event)).to eq(group_event)
    end
  end

  describe "GET #show.json" do
    it "assigns the requested group_event as @group_event" do
      group_event = GroupEvent.create! valid_attributes
      get :show, {:id => group_event.to_param}, format: :json
      expect(assigns(:group_event)).to eq(group_event)
    end
  end

  describe "GET #new" do
    it "assigns a new group_event as @group_event" do
      get :new, {}, valid_session
      expect(assigns(:group_event)).to be_a_new(GroupEvent)
    end
  end

  describe "GET #edit" do
    it "assigns the requested group_event as @group_event" do
      group_event = GroupEvent.create! valid_attributes
      get :edit, {:id => group_event.to_param}, valid_session
      expect(assigns(:group_event)).to eq(group_event)
    end
  end

  describe "GET #edit.json" do
    it "assigns the requested group_event as @group_event" do
      group_event = GroupEvent.create! valid_attributes
      get :edit, {:id => group_event.to_param}, format: :json
      expect(assigns(:group_event)).to eq(group_event)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new GroupEvent" do
        expect {
          post :create, {:group_event => valid_attributes}, valid_session
        }.to change(GroupEvent, :count).by(1)
      end

      it "creates a new GroupEvent.json" do
        expect {
          post :create, {:group_event => valid_attributes}, format: :json
        }.to change(GroupEvent, :count).by(1)
      end

      it "creates a new GroupEvent.json from json body" do
        expect {
          post :create, {:group_event => valid_attributes}.to_json, {'CONTENT_TYPE' => "application/json", 'ACCEPT' => 'application/json'}
        }.to change(GroupEvent, :count).by(1)
      end

      it "assigns a newly created group_event as @group_event" do
        post :create, {:group_event => valid_attributes}, valid_session
        expect(assigns(:group_event)).to be_a(GroupEvent)
        expect(assigns(:group_event)).to be_persisted
      end

      it "redirects to the created group_event" do
        post :create, {:group_event => valid_attributes}, valid_session
        expect(response).to redirect_to(GroupEvent.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved group_event as @group_event" do
        post :create, {:group_event => invalid_attributes}, valid_session
        expect(assigns(:group_event)).to be_a_new(GroupEvent)
      end

      it "re-renders the 'new' template" do
        post :create, {:group_event => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end

      it "reports errors" do
        post :create, {:group_event => invalid_attributes}.to_json, {'CONTENT_TYPE' => "application/json", 'ACCEPT' => 'application/json', format: :json}
        expect(JSON.parse(response.body)['name']).to eq(["can't be blank"])
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
		{ event_start: Time.now, event_end: Time.now + 2.days, event_duration: 2, name: "Event", description: "Test Event", location: "Any", published: true }
      }

      it "updates the requested group_event" do
        group_event = GroupEvent.create! valid_attributes
        put :update, {:id => group_event.to_param, :group_event => new_attributes}, valid_session
        group_event.reload
		expect(group_event.published).to eq(true)
      end

      it "assigns the requested group_event as @group_event" do
        group_event = GroupEvent.create! valid_attributes
        put :update, {:id => group_event.to_param, :group_event => valid_attributes}, valid_session
        expect(assigns(:group_event)).to eq(group_event)
      end

      it "redirects to the group_event" do
        group_event = GroupEvent.create! valid_attributes
        put :update, {:id => group_event.to_param, :group_event => valid_attributes}, valid_session
        expect(response).to redirect_to(group_event)
      end
    end

    context "with invalid params" do
      it "assigns the group_event as @group_event" do
        group_event = GroupEvent.create! valid_attributes
        put :update, {:id => group_event.to_param, :group_event => invalid_attributes}, valid_session
        expect(assigns(:group_event)).to eq(group_event)
      end

      it "re-renders the 'edit' template" do
        group_event = GroupEvent.create! valid_attributes
        put :update, {:id => group_event.to_param, :group_event => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested group_event" do
      group_event = GroupEvent.create! valid_attributes
      expect {
        delete :destroy, {:id => group_event.to_param}, valid_session
      }.to change(GroupEvent, :count).by(0)
    end

    it "redirects to the group_events list" do
      group_event = GroupEvent.create! valid_attributes
      delete :destroy, {:id => group_event.to_param}, valid_session
      expect(response).to redirect_to(group_events_url)
    end
  end

end
