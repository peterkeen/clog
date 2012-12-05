class PostMailer < ActionMailer::Base
  default from: "Pete Keen <pete@bugsplat.info>"

  def send_post(post, recipient)
    @post = post

    mail(
      :to => recipient.email,
      :subject => post.title,
      :from => "#{post.user.name} <#{post.user.email}>"
    )
  end
end
