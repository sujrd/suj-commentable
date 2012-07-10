module Suj
  module Commentable
    module Generators
      class ViewsGenerator < Rails::Generators::Base
        source_root File.expand_path("../../../../../app", __FILE__)
        desc "Adds suj commentable views, scripts and stylesheets to your application."

        def copy_views
          directory "views/suj", "app/views/suj"
        end
        
        def copy_style
          directory "assets/stylesheets/suj", "app/assets/stylesheets"
        end
        
        def copy_controller
          directory "controllers", "app/controllers"
        end
        
        def copy_script
          directory "assets/javascripts", "app/assets/javascripts"
        end
      end
    end
  end
end
