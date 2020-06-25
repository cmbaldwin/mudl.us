class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes, id: false do |t|
      t.bigint :id, primary_key: true
      t.string :fullText
      t.string :expandedUrl

      t.timestamps
    end
  end
end
