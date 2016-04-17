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
        attributes = wine_attributes(record, appellation_for(record))
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

  def wine_attributes(record, appellation)
    {
      api_id: record['Id'],
      name: record['Name'],
      price_retail: record['PriceRetail'],
      appellation: appellation
    }
  end

  def appellation_for(record)
    attributes = {
      api_id: record['Appellation']['Id'],
      name: record['Appellation']['Name'],
      region: record['Appellation']['Region']['Name']
    }
    if appellation = Appellation.find_by(api_id: attributes[:api_id])
      appellation.update(attributes)
    else
      appellation = Appellation.create(attributes)
    end
    appellation
  end
end
