class WineDotComController < ApplicationController
  def load_catalog
    WineDotCom.new(params[:records].to_i).load_catalog
    @notice = "Wine.com records successfully added to the database."
  end

  def dump_catalog
    Wine.where(:api_id.ne => nil).destroy_all
    Appellation.destroy_all
    Varietal.destroy_all
    @notice = "Wine.com records successfully removed from database."
  end
end
