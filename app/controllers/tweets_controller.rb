class TweetsController < ApplicationController
	before_action :set_tweet, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, only: [:edit, :update, :destroy, :tweet_results, :display_change]

	# GET /tweets
	# GET /tweets.json
	def index
		if user_signed_in?
			@tweets = Tweet.search(params[:term]).page params[:page]
		else
			@tweets = Tweet.where(display: true).search(params[:term]).page params[:page]
		end
	end

	def tweet_upload
		require "json"

		tweets = JSON.parse((File.read(open(params[:js]))).gsub(/(window).(YTD).(tweet).(part)\d = /, ''))
		puts 'Total tweets ' + tweets.count.to_s
		if ProcessTwitterTweetsJob.perform_later tweets
			redirect_to tweets_path, notice: '「tweet.js」を処理中です。しばらくお待ちください。'
		else
			redirect_to tweets_path, notice: '「tweet.js」のエラーがありました。ファイルを確認お願い致します。'
		end
	end

	def tweet_results

	end

	def display_change
		Tweet.where(id: tweet_params[:tweet_ids]).each do |tweet|
			tweet.display = true
			tweet.save
		end
		redirect_to tweets_path, notice: '表示設定反映しました。'
	end

	# GET /tweets/1
	# GET /tweets/1.json
	def show
	end

	# GET /tweets/new
	def new
		@tweet = Tweet.new
	end

	# GET /tweets/1/edit
	def edit
	end

	# POST /tweets
	# POST /tweets.json
	def create
		@tweet = Tweet.new(tweet_params)

		respond_to do |format|
			if @tweet.save
				format.html { redirect_to @tweet, notice: 'Tweet was successfully created.' }
				format.json { render :show, status: :created, location: @tweet }
			else
				format.html { render :new }
				format.json { render json: @tweet.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /tweets/1
	# PATCH/PUT /tweets/1.json
	def update
		respond_to do |format|
			if @tweet.update(tweet_params)
				format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
				format.json { render :show, status: :ok, location: @tweet }
			else
				format.html { render :edit }
				format.json { render json: @tweet.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /tweets/1
	# DELETE /tweets/1.json
	def destroy
		@tweet.destroy
		respond_to do |format|
			format.html { redirect_to tweets_url, notice: 'Tweet was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_tweet
			@tweet = Tweet.find(params[:id])
		end

		# Only allow a list of trusted parameters through.
		def tweet_params
			params.require(:tweet).permit(:created_at, :id, :id_str, :text, :truncated, :entities, :source, :in_reply_to_status_id, :in_reply_to_status_id_str, :in_reply_to_user_id, :in_reply_to_user_id_str, :in_reply_to_screen_name, :user, :geo, :coordinates, :place, :contributors, :is_quote_status, :retweet_count, :favorite_count, :favorited, :retweeted, :lang, tweet_ids: [])
		end
end
