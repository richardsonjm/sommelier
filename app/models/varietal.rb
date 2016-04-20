class Varietal
  include Mongoid::Document
  field :api_id, type: Integer
  field :name, type: String
  field :type, type: String

  index({ api_id: 1}, { unique: true })

  has_many :wines

  validates_presence_of :api_id, :name, :type
  validates_numericality_of :api_id
end
