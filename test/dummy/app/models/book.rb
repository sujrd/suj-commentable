class Book
  include Mongoid::Document
  include Suj::Commentable
  acts_as_commentable :order => :desc, :max_depth => 3
end
