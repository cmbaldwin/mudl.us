class Tweet < ApplicationRecord
	serialize :user
	serialize :entities

	def self.search(term)
		if term
			where('text LIKE :search', search: "%#{term}%").order(created_at: :desc)
		else
			order(created_at: :desc)
		end
	end

	def url
		user = 'anyone'
		self.user.nil? ? () : (self.user[:id_str].nil? ? () : (user = self.user[:id_str]))
		"https://twitter.com/" + user.to_s + "/status/" + self.id.to_s
	end

	def no_url_text
		self.text.gsub(/https?:\/\/[\S]+/, '')
	end

	def text_with_links
		self.text.gsub(/https?:\/\/[\S]+/) { |l| "<a href=\"#{l}\" class=\"tweet_link\">#{l}</a>" }
	end

	def links
		links = Array.new
		entity_links = self.entities[:urls]
		regex = self.text[/https?:\/\/[\S]+/]
		if entity_links.empty? && regex
			links = [{url: regex}]
		else
			links = entity_links
		end
		links
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
