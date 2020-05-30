class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets, id: false do |t|
      t.bigint :id, primary_key: true
      t.string :id_str
      t.string :text
      t.boolean :truncated
      t.text :entities
      t.string :source
      t.bigint :in_reply_to_status_id
      t.string :in_reply_to_status_id_str
      t.bigint :in_reply_to_user_id
      t.string :in_reply_to_user_id_str
      t.string :in_reply_to_screen_name
      t.text :user
      t.text :geo
      t.text :coordinates
      t.text :place
      t.text :contributors
      t.boolean :is_quote_status
      t.integer :retweet_count
      t.integer :favorite_count
      t.boolean :favorited
      t.boolean :retweeted
      t.string :lang
      t.boolean :possibly_sensitive

      t.timestamps
    end
  end
end
