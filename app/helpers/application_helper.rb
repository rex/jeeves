module ApplicationHelper
  def folder_url(folder)
    # /Users/pimoore/Code/daikin-master/daikin-cms/public/stylesheets/application.css
    folder.gsub("/", ":")
  end
end
