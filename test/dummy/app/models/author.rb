class Author
  include Mongoid::Document
  include Suj::Commentable
  acts_as_commentable_author :comment_class => "Comment", :name_field => "name", :avatar_field => "avatar"
end
