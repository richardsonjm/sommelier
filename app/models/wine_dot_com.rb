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
        next unless record_valid?(record)
        attributes = wine_attributes(record, appellation_for(record), varietal_for(record))
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

  def record_valid?(record)
    record['Type'] == 'Wine' &&
      record['Id'].try(:present?) &&
      record['Name'].try(:present?) &&
      record['PriceRetail'].try(:present?)
  end

  def wine_attributes(record, appellation, varietal)
    {
      api_id: record['Id'],
      name: record['Name'],
      price_retail: record['PriceRetail'],
      appellation: appellation,
      varietal: varietal
    }
  end

  def appellation_for(record)
    return nil unless record['Appellation']['Id'].present?
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

  def varietal_for(record)
    return nil unless record['Varietal']['Id'].present?
    attributes = {
      api_id: record['Varietal']['Id'],
      name: record['Varietal']['Name'],
      type: record['Varietal']['WineType']['Name']
    }
    if varietal = Varietal.find_by(api_id: attributes[:api_id])
      varietal.update(attributes)
    else
      varietal = Varietal.create(attributes)
    end
    varietal
  end
end
