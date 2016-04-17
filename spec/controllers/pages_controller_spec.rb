require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  describe "GET #dashboar" do
    it "is a success" do
      get :dashboard
      expect(response).to be_success
    end
  end

end
