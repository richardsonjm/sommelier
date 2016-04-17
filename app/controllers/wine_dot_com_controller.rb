class WineDotComController < ApplicationController
  def load_catalog
    WineDotCom.new(params[:records].to_i).load_catalog
  end
end
