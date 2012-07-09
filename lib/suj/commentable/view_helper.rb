module Suj
  module Commentable
    module ViewHelpers
      def comments_for(commentable, author = nil, page = 1, per = 25)
        render :partial => 'suj/commentable/commentable', :formats => [:html], :locals => { :commentable => commentable, :author => author }
      end
      
      def like_url(comment, weight = 1, author = nil, body = "like")
        rate_url(comment, weight, author, body, 1)
      end
      
      def unlike_url(comment, weight = 1, author = nil, body = "unlike")
        rate_url(comment, weight, author, body, -1)
      end
      
      def rate_url(comment, weight = 1, author = nil, body = "rate", mult = 1)
        w = if author.blank?
          weight || 1
        else
          author.rate_weight || 1
        end
        render :partial => "suj/commentable/like_form", :formats => [:html], :locals => { :body => body, :comment => comment, :author => author, :weight => mult.to_i * w.to_i }
      end
    end
  end
end
