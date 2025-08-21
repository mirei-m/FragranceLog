module ApplicationHelper
  def full_title(page_title = "")
    base_title = "FragranceLog"
    if page_title.present?
      "#{page_title}｜#{base_title}"
    else
      base_title
    end
  end

  #タグ表示用
  def display_tags(fragrance)
    return content_tag(:span, "カテゴリ未設定", class: "text-gray-500 text-sm") if fragrance.tags.empty?

    fragrance.tags.map do |tag|
      content_tag :span, tag.name, class: "inline-block bg-accent text-xs px-2 py-1 rounded-full mr-1 mb-1"
    end.join.html_safe
  end
end
