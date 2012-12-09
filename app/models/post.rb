class Post < ActiveRecord::Base
  belongs_to :user
  before_save :slugify

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

    Recipient.where('unsubscribed_at is null').each do |recipient|
      POST_EMAIL_QUEUE.push(
        :post_id             => self.id,
        :recipient_email     => recipient.email,
        :recipient_unique_id => recipient.unique_id
      )
    end
  end
end
