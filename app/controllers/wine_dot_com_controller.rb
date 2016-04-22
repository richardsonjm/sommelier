class WineDotComController < ApplicationController
  def load_catalog
    LoadCatalogJob.perform_later(params[:records].to_i)
    @notice = "Wine.com records being added to database."
  end

  def dump_catalog
    DumpCatalogJob.perform_later
    @notice = "Wine.com records being removed from database."
  end
end
