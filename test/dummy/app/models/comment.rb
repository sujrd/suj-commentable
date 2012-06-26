class Comment
  include Mongoid::Document
  include Suj::Commentable
  acts_as_commentable_comment :commentable_class => "Book"
end
