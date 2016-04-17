require 'rails_helper'

RSpec.describe WineDotCom, type: :model do
  before do
    @wine_dot_com = WineDotCom.new(100)
    @response = {
      "Products" => {
        "List" => [
          { "Id"=>123,
            "Name"=>"Fizz",
            "PriceRetail" => "12.99",
            "Type" => "Wine",
            "Appellation"=> {
              "Id"=>123,
              "Name"=>"Buzz",
              "Region"=> {
                "Id"=>123,
                "Name"=>"FizzBuzz"
              }
            },
            "Varietal"=> {
              "Id"=>123,
              "Name"=>"Foo",
              "WineType"=> {
                "Id"=>123,
                "Name"=>"Bar"
              }
            }
          }
        ]
      }
    }
    allow(@wine_dot_com).to receive(:catalog).and_return(@response)
  end

  subject { @wine_dot_com }

  describe "#load_catalog" do
    it "adds wine record to database" do
      expect {
        subject.load_catalog
      }.to change(Wine, :count).by(1)
    end

    it "doesn't add new record for existing wine" do
      Wine.create(
        api_id: 123,
        name: "Fizz",
        price_retail: "12.99"
      )
      expect {
        subject.load_catalog
      }.not_to change(Wine, :count)
    end

    it "skips non-wine records" do
      @response['Products']['List'][0]['Type'] = 'Beer'
      expect {
        subject.load_catalog
      }.not_to change(Wine, :count)
    end

    it "adds appelation record to database" do
      expect {
        subject.load_catalog
      }.to change(Appellation, :count).by(1)
    end

    it "decrements @records count by @size" do
      subject.instance_variable_set(:@records, 5)
      subject.instance_variable_set(:@size, 10)
      subject.load_catalog
      expect(subject.instance_variable_get(:@records)).to eq -5
    end

    it "increments @offset count by @size" do
      subject.instance_variable_set(:@records, 5)
      subject.instance_variable_set(:@offset, 1)
      subject.instance_variable_set(:@size, 5)
      subject.load_catalog
      expect(subject.instance_variable_get(:@offset)).to eq 6
    end

    it "sets @size count to @records if @size is bigger" do
      subject.instance_variable_set(:@records, 5)
      subject.instance_variable_set(:@size, 10)
      subject.load_catalog
      expect(subject.instance_variable_get(:@size)).to eq -5
    end
  end

  describe "#appellation_for(record)" do
    before do
      @record = @response['Products']['List'][0]
    end

    it "creates new appellation when none exists" do
      expect {
        subject.appellation_for(@record)
      }.to change(Appellation, :count).by(1)
    end

    it "does not create a new record for existing appellation" do
      Appellation.create(
        api_id: @record['Appellation']['Id'],
        name: @record['Appellation']['Name'],
        region: @record['Appellation']['Region']['Name']
      )
      expect {
        subject.appellation_for(@record)
      }.not_to change(Appellation, :count)
    end

    it "returns a appellation record" do
      expect(subject.appellation_for(@record)).to eq Appellation.last
    end
  end
end
