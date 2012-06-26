class Author
  include Mongoid::Document
  include Suj::Commentable::Author
end
