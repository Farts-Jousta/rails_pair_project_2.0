class Track < ApplicationRecord
    has_many :album_tracks
    has_many :albums, through: :album_tracks
end
