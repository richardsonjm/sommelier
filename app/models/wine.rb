class Wine
  include Mongoid::Document
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  field :api_id, type: Integer
  field :name, type: String
  field :price_retail, type: Money

  index({ api_id: 1}, { unique: true })

  belongs_to :appellation
  belongs_to :varietal

  validates_presence_of :name
  validates_numericality_of :price_retail

  def as_indexed_json
    as_json(except: [:id, :_id])
  end
end
