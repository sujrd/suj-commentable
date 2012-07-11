require File.expand_path("view_helper", File.dirname(__FILE__))
require File.expand_path("route_helper", File.dirname(__FILE__))
require File.expand_path("commentable", File.dirname(__FILE__))

module Suj
  module Commentable
    class Engine < Rails::Engine
      # auto wire
      config.generators do |g|
        g.orm :mongoid
      end

      initializer "suj.commentable.view_helpers" do
        ActionView::Base.send :include, Suj::Commentable::ViewHelpers
      end

      initializer "suj.commentable.route_helpers" do
        ActionDispatch::Routing::Mapper.send :include, Suj::Commentable::RouteHelpers
      end
    end
  end
end
