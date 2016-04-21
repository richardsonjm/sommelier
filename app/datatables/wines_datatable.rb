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
        wine.price_retail.try(:dollars),
        wine.appellation.try(:name),
        wine.appellation.try(:region),
        wine.varietal.try(:name),
        wine.varietal.try(:type)
      ]
    end
  end

  def wines
    @wines ||= fetch_wines
  end

  def fetch_wines
    wines = Wine.order("#{sort_column} #{sort_direction}")
    wines = wines.page(page).per(per)
    if search_string.present?
      wines = wines.where(search_terms: search_terms)
    end
    wines
  end

  def search_string
    params[:search][:value]
  end

  def search_terms
    Regexp.new(search_string.split.map {|term| "(?=.*#{term})" }.join.concat(".*"), "i")
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
