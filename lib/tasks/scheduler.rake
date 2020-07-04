namespace :tweets do

	client = Twitter::REST::Client.new do |config|
		config.consumer_key  = ENV['TWITTER_API_KEY']
		config.consumer_secret = ENV['TWITTER_API_SECRET']
		config.access_token = ENV['TWITTER_ACCESS_TOKEN']
		config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
		config.dev_environment     = ENV['TWITTER_DEV_BASIC']
	end

	desc "Scrape 200 recent tweets from authenticated timeline"
	task :scrape_home => :environment do

		puts 'Beginning scrape of @' + ENV['TWITTER_USER']
		puts DateTime.now.to_formatted_s(:rfc822) 
		begin
			@tweets = client.user_timeline(ENV['TWITTER_USER'], count: 200, include_rts: true, tweet_mode: 'extended', trim_user: true)
			puts 'Set from ' + @tweets.first.created_at.to_s + ' to ' + @tweets.last.created_at.to_s + '(' + @tweets.count.to_s + ')'
			@tweets.each_with_index do |tweet, i|
				unless Tweet.exists?(tweet.id)
					new_tweet = Tweet.new
					tweet.attrs.each do |key, val|
						new_tweet.respond_to?(key) ? (new_tweet[key] = val) : ()
					end
					puts 'saving ' + i.to_s + 'of ' + @tweets.count.to_s
					new_tweet.save
				end
			end
			puts 'Finished scraping recent tweets.'
		rescue
			puts 'Rate Limit was likely hit. Try again later.'
		end

	end

	desc "Scrape recent 200 recent favorites from authenticated timeline"
	task :scrape_likes => :environment do

		puts 'Beginning scrape of @' + ENV['TWITTER_USER']
		puts DateTime.now.to_formatted_s(:rfc822)
		begin
			@favorites = client.favorites(count: 200)
			@favorites.each_with_index do |like, i|
				unless Like.exists?(like.id)
					new_like = Like.new
					new_like.id = like.id.to_s
					new_like.fullText = like.full_text
					new_like.expandedUrl = "https://twitter.com/" + like.user.id.to_s + "/status/" + like.id.to_s
					new_like.user_id = like.user.id.to_s
					new_like.screen_name = like.user.screen_name
					new_like.created_at = like.created_at
					puts 'saving ' + i.to_s + 'of ' + @favorites.count.to_s
					new_like.save
				end
			end
			puts 'Finished scraping recent favorites.'
		rescue
			puts 'Rate Limit was likely hit. Try again later.'
		end
	end

	desc "Scrape recent tweets by user as search term (saves interactions)"
	task :scrape_search => :environment do

		puts 'Beginning scrape of @' + ENV['TWITTER_USER']
		start = DateTime.now.to_formatted_s(:rfc822) 

		begin
			@tweets = client.premium_search('codybaldwin', { maxResults: 100 }, { product: '30day' })
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
		rescue
			puts 'Rate Limit was likely hit. Try again next month.'
		end

		puts 'Begun:'
		puts start
		puts 'Finished:'
		puts DateTime.now.to_formatted_s(:rfc822) 

	end

	desc "Unfavorite ~1000 recent favorites older than a week"
	task :unfavorite => :environment do

		start = DateTime.now.to_formatted_s(:rfc822) 
		max_id = nil
		total = 0
		applicable = 0
		5.times do
			max_id.nil? ? (tweets = client.favorites(count: 200)) : (tweets = client.favorites(count: 200, max_id: max_id))
			tweets.each_with_index do |favorite, i|
				if favorite.created_at < (DateTime.now - 7.days)
					favorite.unfavorite
					applicable += 1
				end
			end
			total += tweets.length
			max_id = tweets.last.id
		end

		puts applicable.to_s + ' of ' + total.to_s + ' tweets deleted.'
		puts 'Begun:' + start
		puts 'Finished:' + DateTime.now.to_formatted_s(:rfc822)
	end

	task :scrape => [:scrape_home, :scrape_likes, :scrape_search] do
		puts "Twitter Scrape complete."
	end

end