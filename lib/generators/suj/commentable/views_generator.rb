module Suj
  module Commentable
    module Generators
      class ViewsGenerator < Rails::Generators::Base
        source_root File.expand_path("../../../../../app", __FILE__)
        desc "Adds suj commentable views and stylesheets to your application."

        def copy_views
          directory "views/suj", "app/views/suj"
        end
        
        def copy_style
          directory "assets/stylesheets/suj", "app/assets/stylesheets"
        end

      end
    end
  end
end
