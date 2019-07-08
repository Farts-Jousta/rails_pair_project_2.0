class Artist < ApplicationRecord
    has_many :albums
    def artist_name
        "#{name}"
    end
end
