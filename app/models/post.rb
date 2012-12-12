class Post < ActiveRecord::Base
  belongs_to :user
  before_save :slugify

  attr_accessor :preview_email

  acts_as_taggable

  def slugify
    if self.slug.nil?
      self.slug = self.title.parameterize
    end
  end

  def rendered_body
    RENDERER.render(body)
  end

  def published?
    !self.published_at.nil?
  end

  def publish!
    self.update_attributes(:published_at => DateTime.now)

    recipient_ids = recipients.map { |r| r.id }

    POST_EMAIL_QUEUE.push(
      :post_id => self.id,
      :recipients => recipient_ids
    )
  end

  def recipients
    if self.tags.length > 0
      Recipient.tagged_with(self.tags, :any => true).where('unsubscribed_at is null')
    else
      Recipient.where('unsubscribed_at is null')
    end    
  end

  def send_preview!(email)
    recipient_ids = Recipient.tagged_with('test').map { |r| r.id }

    POST_EMAIL_QUEUE.push(
      :post_id => self.id,
      :recipients => recipient_ids,
      :preview => true
    )
  end
    
end
