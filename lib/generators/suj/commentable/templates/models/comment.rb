class Comment
  inlcude Mongoid::Document
  field :text, :type => String
  field :author, :type => String
  belongs_to :commentable, polymorphic: true
end
