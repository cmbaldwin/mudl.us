module TweetsHelper

	def tweet_url(tweet)
		"https://twitter.com/" + tweet.user[:id_str]+ "/status/" + tweet.id.to_s
	end

end
