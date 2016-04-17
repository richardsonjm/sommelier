require "rails_helper"

RSpec.describe WinesController, type: :routing do
  describe "routing" do

    it "routes to #dashboard" do
      expect(:get => "/dashboard").to route_to("pages#dashboard")
    end

  end
end
