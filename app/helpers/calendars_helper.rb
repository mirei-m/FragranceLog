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
      happy:   "#FACC15", # yellow-400
      relaxed: "#6EE7B7", # green-300
      neutral: "#9CA3AF", # gray-400
      sad:     "#60A5FA", # blue-400
      angry:   "#F87171", # red-400
      tired:   "#A78BFA" # purple-400
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
