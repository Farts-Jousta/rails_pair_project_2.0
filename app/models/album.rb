class Album < ApplicationRecord
    belongs_to :artist
    has_many :album_tracks
    has_many :tracks, through: :album_tracks
end
