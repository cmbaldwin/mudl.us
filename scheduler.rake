namespace :tweets do

	client = Twitter::REST::Client.new do |config|
		config.consumer_key  = ENV['TWITTER_API_KEY']
		config.consumer_secret = ENV['TWITTER_API_SECRET']
		config.access_token = ENV['TWITTER_ACCESS_TOKEN']
		config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
		config.dev_environment     = ENV['TWITTER_DEV_BASIC']
	end

	desc "Scrape recent 3,200 recent tweets from home timeline"
	task :scrape_home => :environment do

		puts 'Beginning scrape of @' + ENV['TWITTER_USER']
		puts DateTime.now.to_formatted_s(:rfc822) 
		from_index = client.user_timeline(ENV['TWITTER_USER'], count: 1).last.id
		stop = false
		until stop
			@tweets = client.user_timeline(ENV['TWITTER_USER'], count: 200, include_rts: true, tweet_mode: 'extended', trim_user: true, max_id: from_index)
			puts 'Set from ' + @tweets.first.created_at.to_s + ' to ' + @tweets.last.created_at.to_s + '(' + @tweets.count.to_s + ')'
			@tweets.each_with_index do |tweet, i|
				unless Tweet.exists?(tweet.id)
					new_tweet = Tweet.new
					tweet.attrs.each do |key, val|
						new_tweet.respond_to?(key) ? (new_tweet[key] = val) : ()
					end
					puts 'saving ' + i.to_s + 'of ' + @tweets.count.to_s
					new_tweet.save
					ap new_tweet
				end
			end
			(from_index == @tweets.last.id) ? (stop = true) : from_index = @tweets.last.id
		end

	end

	desc "Scrape recent tweets by user as search term"
	task :scrape_search => :environment do

		puts 'Beginning scrape of @' + ENV['TWITTER_USER']
		start = DateTime.now.to_formatted_s(:rfc822) 

		@tweets = client.premium_search('codybaldwin', { maxResults: 100 }, { product: '30day' })
		ap @tweets.attrs
		@tweets.each_with_index do |tweet, i|
			unless Tweet.exists?(tweet.id)
				new_tweet = Tweet.new
				tweet.attrs.each do |key, val|
					new_tweet.respond_to?(key) ? (new_tweet[key] = val) : ()
				end
				puts 'saving ' + i.to_s + 'of ' + @tweets.count.to_s
				new_tweet.save
			else
				puts i.to_s + 'of ' + @tweets.count.to_s + ' was already saved'
			end
		end

		puts 'Begun:'
		puts start
		puts 'Finished:'
		puts DateTime.now.to_formatted_s(:rfc822) 

	end

end