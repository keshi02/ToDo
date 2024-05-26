module ApplicationHelper
  def flash_background_color(type)
    case type.to_sym
    when :success then "bg-green-500"
    when :danger  then "bg-red-500"
    when :warning  then "bg-yellow-500"
    else "bg-gray-500"
    end
  end
end
