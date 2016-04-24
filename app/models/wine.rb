class Wine
  include Mongoid::Document
  field :api_id, type: Integer
  field :name, type: String
  field :price_retail, type: Money
  field :search_terms, type: String

  index({ api_id: 1}, { unique: true })

  belongs_to :appellation
  belongs_to :varietal

  validates_presence_of :name
  validates_numericality_of :price_retail

  before_save do |document|
    attributes = [
      document.name,
      document.appellation.try(:name),
      document.appellation.try(:region),
      document.varietal.try(:name),
      document.varietal.try(:type)
    ]
    document.search_terms = attributes.compact.join(' ')
  end

  def self.search(search_terms)
    Wine.where(search_terms: search_to_regex(search_terms))
  end

  def self.search_to_regex(search_terms)
    Regexp.new(search_terms.split.map {|term| "(?=.*#{term})" }.join.concat(".*"), "i")
  end
end
