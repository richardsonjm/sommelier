class Wine
  include Mongoid::Document
  field :api_id, type: Integer
  field :name, type: String
  field :price_retail, type: String

  index({ api_id: 1}, { unique: true })

  belongs_to :appellation

  validates_presence_of :name, :price_retail
end
