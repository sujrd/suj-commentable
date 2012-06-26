module Suj
  module Commentable
    module Author
      extend ActiveSupport::Concern
      included do |base|
        base.field :name
        base.field :avatar
        base.has_many :comments, as: :author
        base.index [['comments', Mongo::ASCENDING]]
      end
    end
  end
end
