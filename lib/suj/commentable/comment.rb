require "active_support/time_with_zone"
module Suj
  module Commentable
    module Comment
      extend ActiveSupport::Concern
      included do |base|
        base.field :text
        base.field :author
        base.field :avatar
        base.field :created_at, type: ActiveSupport::TimeWithZone, default: ->{ Time.now }
        base.field :deleted_at, type: ActiveSupport::TimeWithZone
        base.belongs_to :commentable, polymorphic: true
        base.belongs_to :author, polymorphic: true
        base.validates_presence_of :text
      end
    end
  end
end
