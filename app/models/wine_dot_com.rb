class WineDotCom
  include HTTParty
  base_uri ENV['WINE_URL']

  def initialize(records)
    @records = records
    @size = records > 100 ? 100 : records
    @offset = 1
  end

  def catalog
    options = { query: {size: @size, offset: @offset, apikey: ENV['WINE_KEY']} }
    self.class.get("/catalog", options)
  end

  def load_catalog
    while @records > 0
      response = self.catalog
      response['Products']['List'].each do |record|
        next unless record['Type'] == 'Wine'
        attributes = {
          api_id: record['Id'],
          name: record['Name'],
          price_retail: record['PriceRetail']
        }
        if wine = Wine.find_by(api_id: attributes[:api_id])
          wine.update(attributes)
        else
          Wine.create(attributes)
        end
      end
      @records -= @size
      @offset += @size
      @size = @size > @records ? @records : @size
    end
  end
end
