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

end
