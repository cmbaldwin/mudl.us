require "application_system_test_case"

class TweetsTest < ApplicationSystemTestCase
  setup do
    @tweet = tweets(:one)
  end

  test "visiting the index" do
    visit tweets_url
    assert_selector "h1", text: "Tweets"
  end

  test "creating a Tweet" do
    visit tweets_url
    click_on "New Tweet"

    fill_in "Contributors", with: @tweet.contributors
    fill_in "Coordinates", with: @tweet.coordinates
    fill_in "Created at", with: @tweet.created_at
    fill_in "Entities", with: @tweet.entities
    fill_in "Favorite count", with: @tweet.favorite_count
    check "Favorited" if @tweet.favorited
    fill_in "Geo", with: @tweet.geo
    fill_in "Id", with: @tweet.id
    fill_in "Id str", with: @tweet.id_str
    fill_in "In reply to screen name", with: @tweet.in_reply_to_screen_name
    fill_in "In reply to status", with: @tweet.in_reply_to_status_id
    fill_in "In reply to status id str", with: @tweet.in_reply_to_status_id_str
    fill_in "In reply to user", with: @tweet.in_reply_to_user_id
    fill_in "In reply to user id str", with: @tweet.in_reply_to_user_id_str
    check "Is quote status" if @tweet.is_quote_status
    fill_in "Lang", with: @tweet.lang
    fill_in "Place", with: @tweet.place
    fill_in "Retweet count", with: @tweet.retweet_count
    check "Retweeted" if @tweet.retweeted
    fill_in "Source", with: @tweet.source
    fill_in "Text", with: @tweet.text
    check "Truncated" if @tweet.truncated
    fill_in "User", with: @tweet.user
    click_on "Create Tweet"

    assert_text "Tweet was successfully created"
    click_on "Back"
  end

  test "updating a Tweet" do
    visit tweets_url
    click_on "Edit", match: :first

    fill_in "Contributors", with: @tweet.contributors
    fill_in "Coordinates", with: @tweet.coordinates
    fill_in "Created at", with: @tweet.created_at
    fill_in "Entities", with: @tweet.entities
    fill_in "Favorite count", with: @tweet.favorite_count
    check "Favorited" if @tweet.favorited
    fill_in "Geo", with: @tweet.geo
    fill_in "Id", with: @tweet.id
    fill_in "Id str", with: @tweet.id_str
    fill_in "In reply to screen name", with: @tweet.in_reply_to_screen_name
    fill_in "In reply to status", with: @tweet.in_reply_to_status_id
    fill_in "In reply to status id str", with: @tweet.in_reply_to_status_id_str
    fill_in "In reply to user", with: @tweet.in_reply_to_user_id
    fill_in "In reply to user id str", with: @tweet.in_reply_to_user_id_str
    check "Is quote status" if @tweet.is_quote_status
    fill_in "Lang", with: @tweet.lang
    fill_in "Place", with: @tweet.place
    fill_in "Retweet count", with: @tweet.retweet_count
    check "Retweeted" if @tweet.retweeted
    fill_in "Source", with: @tweet.source
    fill_in "Text", with: @tweet.text
    check "Truncated" if @tweet.truncated
    fill_in "User", with: @tweet.user
    click_on "Update Tweet"

    assert_text "Tweet was successfully updated"
    click_on "Back"
  end

  test "destroying a Tweet" do
    visit tweets_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Tweet was successfully destroyed"
  end
end
