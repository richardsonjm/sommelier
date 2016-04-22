class DumpCatalogJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    Wine.where(:api_id.ne => nil).destroy_all
    Appellation.destroy_all
    Varietal.destroy_all
  end
end
