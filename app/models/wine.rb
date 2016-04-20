class Wine
  include Mongoid::Document
  field :api_id, type: Integer
  field :name, type: String
  field :price_retail, type: Money

  index({ api_id: 1}, { unique: true })

  belongs_to :appellation
  belongs_to :varietal

  validates_presence_of :name
  validates_numericality_of :price_retail
end
