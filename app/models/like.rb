class Like < ApplicationRecord

	def self.search(term)
		if term
			where('full_text LIKE :search OR screen_name LIKE :search', search: "%#{term}%").order(created_at: :desc)
		else
			order(created_at: :desc)
		end
	end

	def url
		self.expandedUrl
	end

	def no_url_text
		self.full_text.gsub(/https?:\/\/[\S]+/, '')
	end

	def text_with_links
		self.full_text.gsub(/https?:\/\/[\S]+/) { |l| "<a href=\"#{l}\" class=\"like_link\">#{l}</a>" }
	end

	def links
		regex = self.full_text[/https?:\/\/[\S]+/]
		regex ? [{url: regex}] : []
	end

	def thumbnails
		thumbnails = Array.new
		self.links.each do |link|
			begin
			  thumbnails << LinkThumbnailer.generate(link[:url], verify_ssl: false)
			rescue LinkThumbnailer::Exceptions => e
			  puts "Thumbnail error: \"#{e}\". 1 skipped."
			end
		end
		thumbnails
	end

end
