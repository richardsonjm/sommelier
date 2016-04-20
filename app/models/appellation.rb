class Appellation
  include Mongoid::Document
  field :api_id, type: Integer
  field :name, type: String
  field :region, type: String

  index({ api_id: 1}, { unique: true })

  has_many :wines

  validates_presence_of :api_id, :name, :region
  validates_numericality_of :api_id
end
