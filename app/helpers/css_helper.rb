module CssHelper
  def parse_stylesheet(stylesheet_path)
    puts " > Parsing stylesheet: #{stylesheet_path}"

    Css::Stylesheet.new(stylesheet_path)
  end

  def parse_custom(stylesheet_path)
    # Read stylesheet and strip all whitespace
    css_content = strip( File.read(stylesheet_path) )

    tree = Sass::Engine.new(css_content, :syntax => :scss).to_tree.to_a
    # css_content
  end

  def strip(content)
    # content.gsub(/\s+/, "")
    content
  end

  def discover_stylesheet_colors(node_list)
    colors = []

    # 
  end
end
