require 'rails_helper'

RSpec.describe WineDotComController, type: :controller do
  describe "GET #load_catalog" do
    it "calls load_catalog a an instance of WineDotCom" do
      expect_any_instance_of(WineDotCom).to receive(:load_catalog).and_return('foo')
      xhr :get, :load_catalog, format: :js
    end
  end

  describe "DELETE #dump_catalog" do
    it "calls dump_catalog a an instance of WineDotCom" do
      expect(Wine).to receive_message_chain('where.destroy_all').and_return('foo')
      expect(Appellation).to receive(:destroy_all).and_return('bar')
      expect(Varietal).to receive(:destroy_all).and_return('baz')
      xhr :delete, :dump_catalog, format: :js
    end

    it 'leaves user created records in the database' do
      expect {
        Wine.create(name: 'foo', price_retail: '2.99')
      }.to change(Wine, :count).by(1)
      expect {
        xhr :delete, :dump_catalog, format: :js
      }.not_to change(Wine, :count)
    end
  end
end
