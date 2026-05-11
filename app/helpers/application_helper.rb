module ApplicationHelper
  def mbti_color_class(type)
    case type
    when "INTJ", "INTP", "ENTJ", "ENTP"
      "#8E44AD" # 紫
    when "INFJ", "INFP", "ENFJ", "ENFP"
      "#2ECC71" # 黄緑
    when "ISTJ", "ISFJ", "ESTJ", "ESFJ"
      "#3498DB" # 水色
    when "ISTP", "ISFP", "ESTP", "ESFP"
      "#F1C40F" # 黄色
    else
      "#dfe6e9" # グレー（未設定など）
    end
  end
end
