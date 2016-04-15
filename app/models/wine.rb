class Wine
  include Mongoid::Document
  field :name, type: String
  field :price_retail, type: String

  validates_presence_of :name, :price_retail
end
