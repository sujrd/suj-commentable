module Suj
  module Commentable
    class Comment
      include Mongoid::Document
      include Mongoid::Tree
      include Mongoid::Rateable
      field :text
      field :created_at, type: ActiveSupport::TimeWithZone, default: ->{ Time.now }
      field :deleted_at, type: ActiveSupport::TimeWithZone
      belongs_to :author, polymorphic: true
      belongs_to :commentable, polymorphic: true
      validates_presence_of :text
      validate :validate_max_depth
      scope :by_date_asc, asc(:created_at)
      scope :by_date_desc, desc(:created_at)
      
      private
      
      def validate_max_depth
        if commentable.class.max_depth >= 1 and self.parent and (self.parent.depth + 1) >= commentable.class.max_depth
          errors.add(:depth, "cannot be larger than #{commentable.class.max_depth}")
        end
      end
    end
  end
end
