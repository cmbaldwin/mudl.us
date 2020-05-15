class OhayoController < ApplicationController

	def index

		require 'flickr'

		flickr = Flickr.new(ENV['FLICKR_API_KEY'])

		user = flickr.users(ENV['FLICKR_USER'])
		@photo = user.photos[rand(100)]
		@photo_url = @photo.sizes.last["source"]
		@exif_data = Hash.new
		@photo.exif["exif"].each do |exif_hash|
			if exif_hash.is_a?(Hash)
				@exif_data[exif_hash["label"]] = exif_hash["raw"]
			end
		end

	end

end
