module ApplicationHelper
  def full_title(page_title)
    base_title = 'General Concert'
    if page_title.blank?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  # 引数で与えられたユーザのGravatar画像を返す
  def gravatar_for(user, size: 80)
    gravatar_id = Digest::MD5.hexdigest(user.email)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: 'gravatar')
  end
end
