module ApplicationHelper
  def gravatar_for(user, options = {size: 80})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  #url = "/Users/vinothcd/rails_project/alpha-blog/app/assets/images/UNADJUSTEDNONRAW_thumb_1.jpg ?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class: "img-circle")
  end
end
