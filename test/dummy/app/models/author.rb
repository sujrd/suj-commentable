class Author
  include Mongoid::Document
  include Suj::Commentable
  acts_as_commentable_author :name_field => "name", :avatar_field => "avatar"
  field :email
end
