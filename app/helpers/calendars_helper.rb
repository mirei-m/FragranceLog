module CalendarsHelper
  def weather_icon_tag(key)
    return unless key.present?
    style = {
      sunny:    "#FFD43B",
      cloudy:   "#9CA3AF",
      rainy:    "#3B82F6",
      snowy:    "#BFDBFE"
    }[key.to_sym] || "#D1D5DB"

    icon = {
      sunny:    "sun",
      cloudy:   "cloud",
      rainy:    "umbrella",
      snowy:    "snowflake"
    }[key.to_sym] || "question"

    tag.i class: "fa-solid fa-#{icon}", style: "color: #{style};"
  end

  def mood_icon_tag(key)
    return unless key.present?
    style = {
      happy:   "#FACC15",
      relaxed: "#6EE7B7",
      neutral: "#9CA3AF",
      sad:     "#60A5FA",
      angry:   "#F87171",
      tired:   "#A78BFA"
    }[key.to_sym] || "#D1D5DB"

    icon = {
      happy:   "face-laugh",
      relaxed: "face-smile",
      neutral: "face-meh",
      sad:     "face-sad-tear",
      angry:   "face-angry",
      tired:   "face-tired"
    }[key.to_sym] || "question"

    tag.i class: "fa-solid fa-#{icon}", style: "color: #{style};"
  end
end
