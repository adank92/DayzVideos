module UsersHelper
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{options[:size]}"
    image_tag gravatar_url, alt: user.name, class: 'gravatar'
  end

  def user_voted_for?(video)
    return false unless logged_in?
    current_user.voted_for?(video)
  end
end
