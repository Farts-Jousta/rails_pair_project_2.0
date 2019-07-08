json.extract! album, :id, :title, :year, :description, :created_at, :updated_at
json.url album_url(album, format: :json)
