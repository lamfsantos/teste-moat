class ArtistsController < ApplicationController
	require 'json'
	require "uri"
	require "net/http"

	def index
		@artists = get_list_of_artists
	end

	def get_list_of_artists
	    json_artists = request_json_artists(ENV['GET_ARTISTS_URL'], ENV['REQUEST_HEADER'])
	    json_artists = format_json(json_artists)

	    list_of_artists = parse_to_list_of_objects(json_artists[0])
	    list_of_artists
	end

	def parse_to_list_of_objects(json_artists)
		list_of_objects = []

		i = 0
		loop { 

			list_of_objects <<  parse_to_object(json_artists[i])
			if i == json_artists.size - 1
				break
			end
			i+=1
		}

		list_of_objects
	end

	def format_json(json_artists)
		JSON.parse(json_artists).values
	end

	def parse_to_object(artist_hash)
		artist_hash = artist_hash[0]

		artist = Artist.new

		artist.id = artist_hash['id']
		artist.twitter = artist_hash['twitter']
		artist.name = artist_hash['name']

		artist
	end

	def request_json_artists(url, header)
		url = URI(url)
	    https = Net::HTTP.new(url.host, url.port)
	    https.use_ssl = true

	    request = Net::HTTP::Get.new(url)
	    request["Authorization"] = header

	    response = https.request(request)

	    response.read_body
	end

	def get_artists_by_id(list_of_artists)
		list_of_artists = list_of_artists & list_of_artists
		result_list = []
		i = 0;
	    loop{
	    	result_list << request_json_artists(ENV['GET_ARTISTS_URL']+"?artist_id="+list_of_artists[i], ENV['REQUEST_HEADER'])

			if i == list_of_artists.size - 1
				break
			end

	      i+=1
	    }
		result_list
	end

	def get_artist_by_id(artist_id)
		artist = request_json_artists(ENV['GET_ARTISTS_URL']+"?artist_id="+artist_id, ENV['REQUEST_HEADER'])
		parse_to_object(format_json(artist)[0])
	end
end
