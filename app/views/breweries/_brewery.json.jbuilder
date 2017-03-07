json.extract! brewery, :id, :name, :year, :active

json.beers brewery.beers.count

json.url brewery_url(brewery, format: :json)