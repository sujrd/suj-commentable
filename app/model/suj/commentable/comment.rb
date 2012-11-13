module Suj
  module Commentable
    class Comment
      include Mongoid::Document
      include Mongoid::Tree
      include Mongoid::Rateable
      field :text
      field :created_at, type: ActiveSupport::TimeWithZone, default: ->{ Time.now }
      field :replied_at, type: ActiveSupport::TimeWithZone, default: ->{ Time.now }
      field :deleted_at, type: ActiveSupport::TimeWithZone
      field :closed_at, type: ActiveSupport::TimeWithZone
      belongs_to :author, polymorphic: true
      belongs_to :commentable, polymorphic: true
      validates_presence_of :text
      validates_presence_of :commentable
      before_create :notify_commentable_before_create
      after_create :update_root, :notify_commentable_after_create
      before_destroy :delete_descendants, :notify_commentable_before_destroy
      validate :validate_max_depth
      scope :by_date_asc, asc(:replied_at)
      scope :by_date_desc, desc(:replied_at)
      
      def close
        update_attribute :closed_at, Time.now
      end

      def open
        update_attribute :closed_at, nil
      end

      def closed?
        ! self.closed_at.nil?
      end
      
      def enable!
        update_attribute :deleted_at, nil
      end

      def disable!
        update_attribute(:deleted_at, Time.now) if enabled?
      end

      def enabled?
        self.deleted_at.nil?
      end

      def like!(user)
        return if ! user
        weight = user.rate_weight || 1
        rate_and_save weight, user
        notify_commentable_after_like(user)
      end

      def unlike!(user)
        return if ! user
        weight = (user.rate_weight || 1) * -1
        rate_and_save weight, user
        notify_commentable_after_unlike(user)
      end

      # Helper method to force destroy of the client no matter if it is enabled or
      # disabled.
      def destroy!
        self.disable!
        self.destroy
      end

      # Override destroy method so it verifies if the client is enabled or not, If
      # enabled this method will only disable it and if disabled then this method
      # will destroy it.
      def destroy
        if enabled?
          self.disable!
        else
          super
        end
      end

      private
      
      def validate_max_depth
        if commentable.blank?
          errors.add(:commentable, "cannot be nil")
          return
        end
        
        if commentable.class.max_depth >= 1 and self.parent and (self.parent.depth + 1) >= commentable.class.max_depth
          errors.add(:depth, "cannot be larger than #{commentable.class.max_depth}")
        end
      end
      
      def update_root
        self.root.update_attributes(:replied_at => Time.now)
      end

      def notify_commentable_before_create
        commentable.send(:before_create_comment, self) if commentable.respond_to?(:before_create_comment, true)
      end
      def notify_commentable_after_create
        commentable.send(:after_create_comment, self) if commentable.respond_to?(:after_create_comment, true)
      end

      def notify_commentable_before_destroy
        commentable.send(:before_destroy_comment, self) if commentable.respond_to?(:before_destroy_comment, true)
      end

      def notify_commentable_after_like(user)
        commentable.send(:after_like_comment, self, user) if commentable.respond_to?(:after_like_comment, true)
      end

      def notify_commentable_after_unlike(user)
        commentable.send(:after_unlike_comment, self, user) if commentable.respond_to?(:after_unlike_comment, true)
      end
    end
  end
end
