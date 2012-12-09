class Recipient < ActiveRecord::Base
  before_save :populate_unique_id

  acts_as_taggable

  def populate_unique_id
    if self.unique_id.nil?
      self.unique_id = SecureRandom.hex(20)
    end
  end

  def unsubscribe!
    self.update_attributes(:unsubscribed_at => Time.now.utc)
  end
end
