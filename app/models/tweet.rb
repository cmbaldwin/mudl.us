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

end
