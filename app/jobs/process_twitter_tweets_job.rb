class ProcessTwitterTweetsJob < ApplicationJob
	queue_as :default

	def perform(tweets)
		tweets.each_with_index do |twhash, i|
			tweet = twhash["tweet"]
			id = tweet["id_str"].to_i
			unless Tweet.exists?(id)
				new_tweet = Tweet.new(id: id)
				tweet.each do |key, val|
					new_tweet.respond_to?(key) ? (new_tweet[key] = val) : ()
					key == "full_text" ? new_tweet[:text] = val : ()
				end
				puts 'saving ' + i.to_s + 'of ' + tweets.count.to_s
				new_tweet.save
			end
		end
	end
end
