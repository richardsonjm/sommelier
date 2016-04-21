class Varietal
  include Mongoid::Document
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  field :api_id, type: Integer
  field :name, type: String
  field :type, type: String

  index({ api_id: 1}, { unique: true })

  has_many :wines

  validates_presence_of :api_id, :name, :type
  validates_numericality_of :api_id

  def as_indexed_json
    as_json(except: [:id, :_id])
  end
end
