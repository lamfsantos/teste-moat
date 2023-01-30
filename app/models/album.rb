class Album < ApplicationRecord
	validates :artist, presence: true
	validates :album_name, presence: true
	validates :year, presence: true

	belongs_to :user
end
