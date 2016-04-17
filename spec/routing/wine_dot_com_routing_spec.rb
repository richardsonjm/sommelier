require "rails_helper"

RSpec.describe WinesController, type: :routing do
  describe "routing" do

    it "routes to #load_catalog" do
      expect(:get => "/load_catalog").to route_to("wine_dot_com#load_catalog")
    end

  end
end
