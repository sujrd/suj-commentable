module Suj
  module Commentable
    module RouteHelpers
      def commentable_for(model)
        resources :comments, :only => [] do
          put 'like', :on => :member
          put 'unlike', :on => :member
        end
        resources model do
          resources :comments, :only => [:create, :destroy]
        end
      end
    end
  end
end
