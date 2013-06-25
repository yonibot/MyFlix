class CreateReviews < ActiveRecord::Migration
  def up
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :video_id
      t.integer :rating
      t.text :content
      t.timestamps
    end
  end

  def down
    drop_table :reviews
  end
end