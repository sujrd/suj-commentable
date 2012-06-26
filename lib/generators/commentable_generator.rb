module Suj
  module Commentable
    module Generators
      class InstallGenerator < Rails::Generators::Base
        source_root File.expand_path("../../templates", __FILE__)
        desc "Creates suj commentable helpers and models."

        def copy_views
          directory "views/comments", "app/views/comments"
        end

        def copy_model
          template "models/comment.rb", "app/models/comment.rb"
        end
      end
    end
  end
end
