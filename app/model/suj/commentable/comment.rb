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
      scope :by_date_asc, asc(:created_at)
      scope :by_date_desc, desc(:created_at)
    end
  end
end
