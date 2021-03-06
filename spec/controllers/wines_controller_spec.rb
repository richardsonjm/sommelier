require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe WinesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Wine. As you add validations to Wine, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {name: 'foo', price_retail: '30'}
  }

  let(:invalid_attributes) {
    {name: 'foo', price_retail: ''}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # WinesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns renders template for html" do
      wine = Wine.create! valid_attributes
      get :index, {}, valid_session
      expect(response).to render_template("index")
    end

    it "assigns calls WinesDatatable for json" do
      wine = Wine.create! valid_attributes
      expect(WinesDatatable).to receive(:new)
      xhr :get, :index, format: :json
    end
  end

  describe "GET #show" do
    it "assigns the requested wine as @wine" do
      wine = Wine.create! valid_attributes
      get :show, {:id => wine.to_param}, valid_session
      expect(assigns(:wine)).to eq(wine)
    end
  end

  describe "GET #new" do
    it "assigns a new wine as @wine" do
      get :new, {}, valid_session
      expect(assigns(:wine)).to be_a_new(Wine)
    end
  end

  describe "GET #edit" do
    it "assigns the requested wine as @wine" do
      wine = Wine.create! valid_attributes
      get :edit, {:id => wine.to_param}, valid_session
      expect(assigns(:wine)).to eq(wine)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Wine" do
        expect {
          post :create, {:wine => valid_attributes}, valid_session
        }.to change(Wine, :count).by(1)
      end

      it "assigns a newly created wine as @wine" do
        post :create, {:wine => valid_attributes}, valid_session
        expect(assigns(:wine)).to be_a(Wine)
        expect(assigns(:wine)).to be_persisted
      end

      it "redirects to the created wine" do
        post :create, {:wine => valid_attributes}, valid_session
        expect(response).to redirect_to(Wine.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved wine as @wine" do
        post :create, {:wine => invalid_attributes}, valid_session
        expect(assigns(:wine)).to be_a_new(Wine)
      end

      it "re-renders the 'new' template" do
        post :create, {:wine => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {name: 'bar', price_retail: '30'}
      }

      it "updates the requested wine" do
        wine = Wine.create! valid_attributes
        put :update, {:id => wine.to_param, :wine => new_attributes}, valid_session
        wine.reload
        expect(wine.name).to eq 'bar'
      end

      it "assigns the requested wine as @wine" do
        wine = Wine.create! valid_attributes
        put :update, {:id => wine.to_param, :wine => valid_attributes}, valid_session
        expect(assigns(:wine)).to eq(wine)
      end

      it "redirects to the wine" do
        wine = Wine.create! valid_attributes
        put :update, {:id => wine.to_param, :wine => valid_attributes}, valid_session
        expect(response).to redirect_to(wine)
      end
    end

    context "with invalid params" do
      it "assigns the wine as @wine" do
        wine = Wine.create! valid_attributes
        put :update, {:id => wine.to_param, :wine => invalid_attributes}, valid_session
        expect(assigns(:wine)).to eq(wine)
      end

      it "re-renders the 'edit' template" do
        wine = Wine.create! valid_attributes
        put :update, {:id => wine.to_param, :wine => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested wine" do
      wine = Wine.create! valid_attributes
      expect {
        delete :destroy, {:id => wine.to_param}, valid_session
      }.to change(Wine, :count).by(-1)
    end

    it "redirects to the wines list" do
      wine = Wine.create! valid_attributes
      delete :destroy, {:id => wine.to_param}, valid_session
      expect(response).to redirect_to(wines_url)
    end
  end

end
