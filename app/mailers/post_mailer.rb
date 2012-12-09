class PostMailer < ActionMailer::Base
  default from: "Pete Keen <pete@bugsplat.info>"

  def send_post(args)
    post_id = args[:post_id]
    recipient_email = args[:recipient_email]
    recipient_unique_id = args[:recipient_unique_id]

    @post = Post.find(post_id)
    @recipient_unique_id = recipient_unique_id

    subject = args[:preview].nil? ? @post.title : "[PREVIEW] #{@post.title}"

    mail(
      :to => recipient_email,
      :subject => subject,
      :from => "#{@post.user.name} <#{@post.user.email}>",
      :reply_to => "mancer@bugsplat.info"
    )
  end
end
