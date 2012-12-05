class AddPublishedAtToPosts < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.timestamp :published_at
    end
  end
end
