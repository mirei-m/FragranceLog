module ApplicationHelper
  def full_title(page_title = "")
    base_title = "FragranceLog"
    if page_title.present?
      "#{page_title}｜#{base_title}"
    else
      base_title
    end
  end

  # タグ表示用
  def display_tags(fragrance)
    return content_tag(:span, "カテゴリ未設定", class: "text-gray-500 text-sm") if fragrance.tags.empty?

    fragrance.tags.map do |tag|
      content_tag :span, tag.name, class: "inline-block bg-accent text-xs px-2 py-1 rounded-full mr-1 mb-1"
    end.join.html_safe
  end

  # タグ表示部分
  def display_tags(fragrance, context: :review)
    return content_tag(:span, "カテゴリ未設定", class: "text-gray-500 text-sm") if fragrance.tags.empty?

    fragrance.tags.map do |tag|
      link_to reviews_path(q: { fragrance_tags_id_eq: tag.id }),
              class: "inline-block bg-accent hover:bg-accent-focus text-xs px-2 py-1 rounded-full mr-1 mb-1 transition-colors",
              title: "「#{tag.name}」で絞り込み" do
        tag.name
      end
    end.join(" ").html_safe
  end

  # OGP設定
  def default_meta_tags
    {
      site: "FragranceLog",
      title: "香水レビュー・記録・管理アプリ",
      reverse: true,
      charset: "utf-8",
      description: "あなたにぴったりの香りを見つけよう",
      keywords: "香水,レビュー,診断,記録,香り",
      canonical: request.original_url,
      separator: "|",
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: "website",
        url: request.original_url,
        image: image_url("ogp.png"),
        locale: "ja_JP"
      },
      twitter: {
        card: "summary_large_image",
        site: "@", # アプリの公式アカウントがあれば
        image: image_url("ogp.png")
      }
    }
  end
end
