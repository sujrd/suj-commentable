class Book
  include Mongoid::Document
  include Suj::Commentable
  acts_as_commentable :order => :desc
end
