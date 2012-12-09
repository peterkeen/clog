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

    if self.tags.length > 0
      @recipients = Recipient.tagged_with(self.tags, :any => true).where('unsubscribed_at is null')
    else
      @recipients = Recipient.where('unsubscribed_at is null')
    end

    @recipients.each do |recipient|
      POST_EMAIL_QUEUE.push(
        :post_id             => self.id,
        :recipient_email     => recipient.email,
        :recipient_unique_id => recipient.unique_id
      )
    end
  end

  def send_preview!(email)
    POST_EMAIL_QUEUE.push(
      :post_id => self.id,
      :recipient_email => email,
      :recipient_unique_id => "preview",
      :preview => true
    )
  end
    
end
