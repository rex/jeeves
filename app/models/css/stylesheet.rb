module Css
  class Stylesheet
    attr_reader :path, :name, :nodes, :colors, :color_count, :length
    alias :selector_count :length

    def initialize(stylesheet_path)
      @path = stylesheet_path
      @name = File.basename(stylesheet_path)
      @nodes = []

      parse
    end

    def parse      
      puts " > CssHelper::parse #{@path}"
      parser = CssParser::Parser.new
      parser.load_file!(@path)
      colors_discovered = []

      parser.each_selector(:all) do |selector, declarations, specificity, *params|
        node = Css::Node.new(selector, declarations, specificity)
        colors_discovered.concat(node.colors)
        @nodes << node
      end

      @colors = colors_discovered.uniq
      @color_count = @colors.length
      @length = @nodes.length
    end
  end
end
