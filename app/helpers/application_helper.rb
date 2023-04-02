module ApplicationHelper
  def random_color
    turquoise     = "#3b7d87"
    orange        = "#fd712c"
    green         = "#66ac8f"
    light_green   = "#c7e1c2"
    another_green = "#457C7B"
    blue          = "#203846"
    light_blue    = "#72A8C0"

    if defined?(@helper_colors) == nil || @helper_colors.empty?
      @helper_colors = [turquoise, orange, green, light_green, another_green, blue, light_blue]
    end

    color = @helper_colors.sample
    @helper_colors.delete(color)

    return color
  end
end
