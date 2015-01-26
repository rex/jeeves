module Css
  class Node
    attr_reader :selector, :declaration_string, :styles, :specificity, :colors

    def initialize(selector, declaration_string, specificity)
      @selector = selector
      @declaration_string = declaration_string
      @specificity = specificity

      parse

      # puts " >--- :selector #{@selector}"
      # puts " >--- :specificity #{@specificity}"
      # puts " >--- :declaration_string #{@declaration_string}"
      # puts " >--- :styles #{@styles}"
    end

    def parse
      colors_discovered = []

      @styles = @declaration_string.split(";").map do |declaration|
        property, value = declaration.split(":").map(&:strip)
        colors_in_declaration = value.scan(/#([0-9a-f]{6}|[0-9a-f]{3})/i).reject(&:empty?).flatten.uniq

        unless colors_in_declaration.blank?
          colors_discovered.concat(colors_in_declaration)
        end

        {
          declaration: declaration,
          property: property,
          value: value,
          colors: colors_in_declaration
        }
      end

      @colors = colors_discovered
    end
  end
end
