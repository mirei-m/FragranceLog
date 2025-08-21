module FragrancesHelper
  def display_tags(fragrance)
    return content_tag(:span, "未設定", class: "text-gray-500 text-sm") if fragrance.tags.empty?

    fragrance.tags.map do |tag|
      content_tag :span, tag.name, class: "inline-block bg-blue-100 text-blue-800 text-xs px-2 py-1 rounded-full mr-1 mb-1"
    end.join.html_safe
  end
end
