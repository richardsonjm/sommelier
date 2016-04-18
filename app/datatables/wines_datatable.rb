class WinesDatatable
  delegate :params, :link_to, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      recordsTotal: Wine.count,
      recordsFiltered: wines.count,
      data: data
    }
  end

private

  def data
    wines.map do |wine|
      [
        link_to(wine.name, wine),
        wine.price_retail,
        wine.appellation.name,
        wine.appellation.region,
        wine.varietal.name,
        wine.varietal.type
      ]
    end
  end

  def wines
    @wines ||= fetch_wines
  end

  def fetch_wines
    wines = Wine.order("#{sort_column} #{sort_direction}")
    wines = wines.page(page).per(per)
    if params[:search][:value].present?
      wines = wine_matches(wines) | varietal_matches | appellation_matches
    end
    wines
  end

  def search_term
    Regexp.quote(params[:search][:value])
  end

  def wine_matches(wines)
    wines.where(name: /#{search_term}/i)
  end

  def varietal_matches
    varietal_ids = Varietal.where(name: /#{search_term}/i).only(:_id).map(&:_id)
    Wine.where(:varietal_id.in => varietal_ids)
  end

  def appellation_matches
    appellation_ids = Appellation.where(name: /#{search_term}/i).only(:_id).map(&:_id)
    Wine.where(:appellation_id.in => appellation_ids)
  end

  def page
    params[:start].to_i/per + 1
  end

  def per
    params[:length].to_i > 0 ? params[:length].to_i : 10
  end

  def sort_column
    columns = %w(name price_retail not_orderable not_orderable not_orderable not_orderable)
    columns[params[:order][:'0'][:column].to_i]
  end

  def sort_direction
    params[:order][:'0'][:dir] == "desc" ? "desc" : "asc"
  end
end
