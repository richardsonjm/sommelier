class LoadCatalogJob < ActiveJob::Base
  queue_as :default

  def perform(records)
    WineDotCom.new(records).load_catalog
  end

  after_perform do |j|
    # do something to notify user
  end
end
