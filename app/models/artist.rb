class Artist
	include ActiveModel: :Model

	attr_accessor :id, :twitter, :name
end