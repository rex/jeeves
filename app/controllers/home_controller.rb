include CssHelper

class HomeController < ApplicationController
  def index
    home = Pathname.new ENV['HOME']

    puts " > URL Requested: #{request.url}"
    puts " > Query String: #{request.query_parameters}"

    @include_stylesheets = []
    @parsed_stylesheets = {}
    @parsed_custom_stylesheets = {}
    @grouped_stylesheets = {}
    requested_file = request.query_parameters["file"]

    unless requested_file.blank?
      @include_stylesheets << requested_file.gsub(":", "/")

      puts " > Including stylesheets: #{@include_stylesheets}"

      @include_stylesheets.each do |stylesheet|
        puts " > Parsing stylesheet: #{stylesheet}"
        parsed_stylesheet = CssHelper.parse_stylesheet(stylesheet)
        
        @parsed_stylesheets[stylesheet] = parsed_stylesheet
      end

      # @include_stylesheets.each do |stylesheet|
      #   # Break apart the rows and 
      #   #   1) name fields better
      #   #   2) break apart styles per selector
      #   stylesheet[:nodes].each do |node|
      #     # Group styles by node[1] to identify duplicate styles
      #     #   and recommend file separation
      #     if grouped_nodes.has_key?(declarations)
      #       grouped_nodes[declarations] << selector
      #     else
      #       grouped_nodes[declarations] = [selector]
      #     end
      #   end

      #   @parsed_stylesheets[stylesheet] = {
      #     nodes: {
      #       all: node_list,
      #       grouped: grouped_nodes
      #     },
      #     colors: stylesheet_colors,
      #     name: File.basename(stylesheet),
      #     path: stylesheet
      #   }
      # end
    else
      puts " > Requested file is blank! #{requested_file}"
      @include_dirs = [
        "#{::Rails.root.join('app', 'assets', 'stylesheets')}",
        "#{home.join('Code', 'daikin-master', 'daikin-cms', 'public', 'stylesheets')}"
      ]


      @include_dirs.each do |css_dir|
        css_glob = File.join(css_dir, "**", "*.css")
        @include_stylesheets << Dir.glob(css_glob)
      end
      
      @include_stylesheets.flatten!
    end
  end

  def stats
    # 
  end
end
