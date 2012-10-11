module Suj
  module Commentable
    module Generators
      class Install < Rails::Generators::Base
        source_root File.expand_path("../../../../../app", __FILE__)
        desc "Adds suj commentable controllers, views, scripts and stylesheets to your application."

        def copy_views
          directory "views/suj", "app/views/suj"
        end
        
        def copy_controllers
          copy_file "../lib/generators/suj/commentable/templates/controllers/comments_controller.rb", "app/controllers/comments_controller.rb"
        end
        
        def copy_style
          directory "assets/stylesheets/suj", "app/assets/stylesheets"
        end

        def copy_script
          directory "assets/javascripts", "app/assets/javascripts"
        end

        def copy_translations
          directory "../config/locales", "config/locales"
        end
      end
    end
  end
end
