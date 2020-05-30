require 'test_helper'

class TweetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tweet = tweets(:one)
  end

  test "should get index" do
    get tweets_url
    assert_response :success
  end

  test "should get new" do
    get new_tweet_url
    assert_response :success
  end

  test "should create tweet" do
    assert_difference('Tweet.count') do
      post tweets_url, params: { tweet: { contributors: @tweet.contributors, coordinates: @tweet.coordinates, created_at: @tweet.created_at, entities: @tweet.entities, favorite_count: @tweet.favorite_count, favorited: @tweet.favorited, geo: @tweet.geo, id: @tweet.id, id_str: @tweet.id_str, in_reply_to_screen_name: @tweet.in_reply_to_screen_name, in_reply_to_status_id: @tweet.in_reply_to_status_id, in_reply_to_status_id_str: @tweet.in_reply_to_status_id_str, in_reply_to_user_id: @tweet.in_reply_to_user_id, in_reply_to_user_id_str: @tweet.in_reply_to_user_id_str, is_quote_status: @tweet.is_quote_status, lang: @tweet.lang, place: @tweet.place, retweet_count: @tweet.retweet_count, retweeted: @tweet.retweeted, source: @tweet.source, text: @tweet.text, truncated: @tweet.truncated, user: @tweet.user } }
    end

    assert_redirected_to tweet_url(Tweet.last)
  end

  test "should show tweet" do
    get tweet_url(@tweet)
    assert_response :success
  end

  test "should get edit" do
    get edit_tweet_url(@tweet)
    assert_response :success
  end

  test "should update tweet" do
    patch tweet_url(@tweet), params: { tweet: { contributors: @tweet.contributors, coordinates: @tweet.coordinates, created_at: @tweet.created_at, entities: @tweet.entities, favorite_count: @tweet.favorite_count, favorited: @tweet.favorited, geo: @tweet.geo, id: @tweet.id, id_str: @tweet.id_str, in_reply_to_screen_name: @tweet.in_reply_to_screen_name, in_reply_to_status_id: @tweet.in_reply_to_status_id, in_reply_to_status_id_str: @tweet.in_reply_to_status_id_str, in_reply_to_user_id: @tweet.in_reply_to_user_id, in_reply_to_user_id_str: @tweet.in_reply_to_user_id_str, is_quote_status: @tweet.is_quote_status, lang: @tweet.lang, place: @tweet.place, retweet_count: @tweet.retweet_count, retweeted: @tweet.retweeted, source: @tweet.source, text: @tweet.text, truncated: @tweet.truncated, user: @tweet.user } }
    assert_redirected_to tweet_url(@tweet)
  end

  test "should destroy tweet" do
    assert_difference('Tweet.count', -1) do
      delete tweet_url(@tweet)
    end

    assert_redirected_to tweets_url
  end
end
