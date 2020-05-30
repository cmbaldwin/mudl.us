class OhayoController < ApplicationController

	def index
		require 'flickr'

		flickr = Flickr.new(ENV['FLICKR_API_KEY'])

		user = flickr.users(ENV['FLICKR_USER'])
		@photos = user.photos('per_page' => '500')
		@photo = @photos[rand(@photos.count)]
		@photo.sizes.each {|size| (size['label'] == 'Large 2048') ? (@photo_url = size['source']) : () }
		@photo_url.nil? ? @photo_url = @photo.sizes.last["source"] : ()
		@exif_data = Hash.new
		@photo.exif["exif"].each do |exif_hash|
			if exif_hash.is_a?(Hash)
				@exif_data[exif_hash["label"]] = exif_hash["raw"]
			end
		end

	end

end
