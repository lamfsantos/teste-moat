class ArtistsController < ApplicationController
	def get_list_of_artists
	    require "uri"
	    require "net/http"

	    url = URI("https://europe-west1-madesimplegroup-151616.cloudfunctions.net/artists-api-controller")

	    https = Net::HTTP.new(url.host, url.port)
	    https.use_ssl = true

	    request = Net::HTTP::Get.new(url)
	    request["Authorization"] = "Basic ZGV2ZWxvcGVyOlpHVjJaV3h2Y0dWeQ=="

	    response = https.request(request)
	    response.read_body
	  end
end
