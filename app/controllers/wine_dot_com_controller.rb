class WineDotComController < ApplicationController
  def load_catalog
    LoadCatalogJob.perform_later(params[:records].to_i)
    @notice = "Wine.com records being added to database."
  end

  def dump_catalog
    Wine.where(:api_id.ne => nil).destroy_all
    Appellation.destroy_all
    Varietal.destroy_all
    @notice = "Wine.com records successfully removed from database."
  end
end
