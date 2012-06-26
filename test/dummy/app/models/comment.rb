class Comment
  include Mongoid::Document
  include Suj::Commentable::Comment
end
