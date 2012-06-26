module Suj
  module Commentable
    extend ActiveSupport::Concern
    included do |base|
      base.has_many :comments, as: :commentable
      base.index [['comments', Mongo::ASCENDING]]
    end
  end
end
