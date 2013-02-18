require "mongoid/tree"
require "active_support/time_with_zone"
module Suj
  module Commentable
    extend ActiveSupport::Concern

    def ordered_comments
      if self.class.comments_order == :desc
        comments.by_date_desc
      else
        comments.by_date_asc
      end
    end

    module AuthorInstanceMethods
      def can_delete_comment?(comment)
        return true if comment.author and comment.author == self
        return false
      end

      def can_hid_comment?(comment)
        return true if comment.author and comment.author == self
        return false
      end
    end

    module ClassMethods

      @@max_depth = -1
      @@comments_order = :desc

      def comments_order
        @@comments_order
      end

      def comments_order=(order)
        @@comments_order = order
      end

      def max_depth
        @@max_depth
      end

      def max_depth=(val)
        @@max_depth = val
      end

      def acts_as_commentable(options = {})
        @@comments_order = options[:order] || :desc
        @@max_depth = options[:max_depth] || -1
        Suj::Commentable::Comment.paginates_per(options[:paginates_per] || 10)

        has_many :comments, class_name: "Suj::Commentable::Comment",
                            as: :commentable, 
                            dependent: (options[:dependent] || :destroy)

        index({ comments: 1 })
      end

      def acts_as_commentable_author(options = {})
        field (options[:name_field] || :name).to_sym, as: :name
        field (options[:avatar_field] || :avatar).to_sym, as: :avatar
        field :rate_weight, default: 1
        has_many :comments, class_name: "Suj::Commentable::Comment", as: :author
        index({ comments: 1 })
        include AuthorInstanceMethods
      end

    end
  end
end
