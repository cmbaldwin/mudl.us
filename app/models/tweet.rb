class Tweet < ApplicationRecord
	serialize :user
	serialize :entities
end
