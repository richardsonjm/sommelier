class WineDotComController < ApplicationController
  def load_catalog
    WineDotCom.new(params[:records].to_i).load_catalog
  end

  def dump_catalog
    Wine.where(:api_id.ne => nil).destroy_all
  end
end
