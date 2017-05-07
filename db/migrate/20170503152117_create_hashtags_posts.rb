class CreateHashtagsPosts < ActiveRecord::Migration
  def change
    create_table :hashtags_posts do |t|
      t.integer :hashtag_id
      t.integer :post_id

      t.timestamps null: false
    end
  end
end
