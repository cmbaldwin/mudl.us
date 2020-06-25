json.extract! like, :id, :tweetId, :fullText, :expandedUrl, :created_at, :updated_at
json.url like_url(like, format: :json)
