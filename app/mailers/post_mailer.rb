class PostMailer < ActionMailer::Base
  default from: "Pete Keen <pete@bugsplat.info>"

  def send_post(post_id, recipient_email, recipient_unique_id, preview=nil)
    @post = Post.find(post_id)
    @recipient_unique_id = recipient_unique_id

    subject = preview.nil? ? @post.title : "[PREVIEW] #{@post.title}"

    mail(
      :to => recipient_email,
      :subject => subject,
      :from => "#{@post.user.name} <#{@post.user.email}>",
      :reply_to => "mancer@bugsplat.info"
    )
  end

  def send_report(post_id, recipient_emails, preview=false)

    @post = Post.find(post_id)
    subject = preview.nil? ? @post.title : "[PREVIEW] #{@post.title}"

    @emails = recipient_emails

    mail(
      :to => 'mancer@bugsplat.info',
      :subject => "Successfully sent '#{subject}'",
    )
  end
end
