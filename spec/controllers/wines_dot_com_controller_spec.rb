require 'rails_helper'

RSpec.describe WineDotComController, type: :controller do
  describe "GET #load_catalog" do
    it "calls load_catalog a an instance of WineDotCom" do
      expect_any_instance_of(WineDotCom).to receive(:load_catalog).and_return('foo')
      xhr :get, :load_catalog, format: :js
    end
  end
end
