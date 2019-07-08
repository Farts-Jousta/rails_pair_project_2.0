json.extract! artist, :id, :name, :yob, :country, :description, :active, :created_at, :updated_at
json.url artist_url(artist, format: :json)
