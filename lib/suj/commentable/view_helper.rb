module Suj
  module Commentable
    module ViewHelpers
      def comments_for(commentable, author = nil, page = 1, per = 25)
        render :partial => 'suj/commentable/commentable', :formats => [:html], :locals => { :commentable => commentable, :author => author }
      end
    end
  end
end
