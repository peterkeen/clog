POST_EMAIL_QUEUE = GirlFriday::WorkQueue.new(:post_email, :size => 1) do |msg|
  PostMailer.send_post(msg).deliver
end
