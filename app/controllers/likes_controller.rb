class LikesController < ApplicationController
	before_action :set_like, only: [:show, :edit, :update, :destroy]

	# GET /likes
	# GET /likes.json
	def index
		@likes = Like.limit(50).order(:created_at)
	end

	def like_upload
		require "json"

		likes = JSON.parse((File.read(open(params[:js]))).gsub(/(window).(YTD).(like).(part)\d = /, ''))
		puts 'Total likes ' + likes.count.to_s
		if ProcessTwitterLikesJob.perform_later likes
			redirect_to likes_path, notice: '「like.js」を処理中です。しばらくお待ちください。'
		else
			redirect_to likes_path, notice: '「like.js」のエラーがありました。ファイルを確認お願い致します。'
		end
	end

	def like_results

	end

	# GET /likes/1
	# GET /likes/1.json
	def show
	end

	# GET /likes/new
	def new
		@like = Like.new
	end

	# GET /likes/1/edit
	def edit
	end

	# POST /likes
	# POST /likes.json
	def create
		@like = Like.new(like_params)

		respond_to do |format|
			if @like.save
				format.html { redirect_to @like, notice: 'Like was successfully created.' }
				format.json { render :show, status: :created, location: @like }
			else
				format.html { render :new }
				format.json { render json: @like.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /likes/1
	# PATCH/PUT /likes/1.json
	def update
		respond_to do |format|
			if @like.update(like_params)
				format.html { redirect_to @like, notice: 'Like was successfully updated.' }
				format.json { render :show, status: :ok, location: @like }
			else
				format.html { render :edit }
				format.json { render json: @like.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /likes/1
	# DELETE /likes/1.json
	def destroy
		@like.destroy
		respond_to do |format|
			format.html { redirect_to likes_url, notice: 'Like was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_like
			@like = Like.find(params[:id])
		end

		# Only allow a list of trusted parameters through.
		def like_params
			params.require(:like).permit(:tweetId, :fullText, :expandedUrl)
		end
end
