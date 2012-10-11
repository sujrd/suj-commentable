module Suj
  module Commentable
    module RouteHelpers
      def commentable_for(model)
        resources :comments, :only => [] do
          put 'like', :on => :member
          put 'unlike', :on => :member
          put 'open', :on => :member
          put 'close', :on => :member
          put 'hide', :on => :member
          put 'unhide', :on => :member
        end
        resources model do
          resources :comments, :only => [:index, :create]
        end
      end
    end
  end
end
