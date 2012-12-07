class AddUniqueIdAndUnsubscribedAtToRecipient < ActiveRecord::Migration
  def change
    change_table :recipients do |t|
      t.timestamp :unsubscribed_at
      t.string :unique_id
    end
  end
end
