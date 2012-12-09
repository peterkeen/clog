POST_EMAIL_QUEUE = GirlFriday::WorkQueue.new(:post_email) do |msg|
  PostMailer.send_post(msg).deliver
end
