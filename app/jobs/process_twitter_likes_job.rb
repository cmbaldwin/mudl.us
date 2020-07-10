class ProcessTwitterLikesJob < ApplicationJob
	queue_as :default

	def perform(likes)

		client = Twitter::REST::Client.new do |config|
			config.consumer_key  = ENV['TWITTER_API_KEY']
			config.consumer_secret = ENV['TWITTER_API_SECRET']
			config.access_token = ENV['TWITTER_ACCESS_TOKEN']
			config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
			config.dev_environment  = ENV['TWITTER_DEV_BASIC']
		end

		seperated_ids = Array.new
		data_by_id = Hash.new
		skipped_ids = Array.new

		likes.each do |like_hash, i|
			like = like_hash["like"]
			id = like["tweetId"].to_i
			seperated_ids << id
			data_by_id[id] = Hash.new
			data_by_id[id]["fullText"] = like["fullText"]
			data_by_id[id]["expandedUrl"] = like["expandedUrl"]
		end

		total_saved = 0
		seperated_ids.in_groups_of(100).each_with_index do |likes, i|
			begin
				# Twitter accepts 900 in 15 minutes (about 1 request a second, 100 tweets per request)
				tweets = client.statuses(likes)
			rescue
				begin
					# rate limit hit by time?
					sleep(5.seconds)
					tweets = client.statuses(likes)
				rescue
					# API rate limit hit
					skipped_ids << likes
				end
			end
			used_ids = Array.new
			rate_limit_ok = true
			tweets.each_with_index do |tweet|
				id = tweet.id
				unless Like.exists?(id)
					used_ids << id
					!tweet.user.id.to_s.nil? ? (user_id = tweet.user.id.to_s) : (user_id = 0)
					!tweet.user.screen_name.nil? ? (screen_name = tweet.user.screen_name) : (screen_name = 'unknown')
					url = "https://twitter.com/" + (user_id == 0 ? 'anyone' : user_id) + "/status/" + id.to_s
					if tweet.truncated?
						begin
							if rate_limit_ok
								full_text = client.oembed(id).html.gsub("<br>", "\n").gsub(/<[^>]*>/, '')
							else
								full_text = tweet.text
								skipped_ids << id
							end
						rescue
							begin
								# rate limit hit by time?
								sleep(5.seconds)
								full_text = client.oembed(id).html.gsub("<br>", "\n").gsub(/<[^>]*>/, '')
							rescue
								# API rate limit hit
								skipped_ids << id
								rate_limit_ok = false
							end
						end
					else
						full_text = tweet.text
					end
					new_like = Like.new
					new_like.id = id
					new_like.full_text = full_text
					new_like.expandedUrl = url
					new_like.user_id = user_id
					new_like.screen_name = screen_name
					new_like.created_at = tweet.created_at
					puts 'saving ' + i.to_s + 'of ' + likes.count.to_s + ' found likes'
					new_like.save
					total_saved += 1
				else
					puts i.to_s + ' of ' + likes.count.to_s + ' was skipped because it already existed in the database.'
				end
			end
			not_found_ids = (likes - used_ids + skipped_ids).uniq
			puts 'Saving' + not_found_ids.count.to_s + ' likes not found through API using archival data only.'
			not_found_ids.each_with_index do |id, i|
				unless Like.exists?(id)
					tweet = data_by_id[id]
					new_like = Like.new
					new_like.id = id
					new_like.full_text = tweet["fullText"]
					new_like.expandedUrl = tweet["expandedUrl"]
					puts 'saving ' + i.to_s + 'of ' + not_found_ids.count.to_s
					new_like.save
					total_saved += 1
				else
					puts i.to_s + 'of ' + not_found_ids.count.to_s + ' was skipped because it already existed in the database.'
				end
			end
		end
		puts 'Full tweet text skipped because of rate limit:' + skipped_ids.count.to_s
		puts 'Total saved: ' + total_saved.to_s
	end
end
