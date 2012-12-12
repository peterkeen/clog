POST_EMAIL_QUEUE = GirlFriday::WorkQueue.new(:post_email, :size => 1) do |msg|

  recipient_emails = []

  msg[:recipients].each do |recipient_id|
    recipient = Recipient.find(recipient_id)
    PostMailer.send_post(
      msg[:post_id],
      recipient.email,
      recipient.unique_id,
      msg[:preview]
    ).deliver
    recipient_emails << recipient.email
  end

  PostMailer.send_report(
    msg[:post_id],
    recipient_emails,
    msg[:preview]
  ).deliver
end
