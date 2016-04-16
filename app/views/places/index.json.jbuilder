json.array!(@places) do |place|
  json.extract! place, :id, :city, :state, :country, :keywords, :region, :wiki, :language, :image
  json.url place_url(place, format: :json)
end
