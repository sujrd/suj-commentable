require "active_support/time_with_zone"
module Suj
  module Commentable
    extend ActiveSupport::Concern

    module InstanceMethods
      def ordered_comments
        if self.class.comments_order == :desc
          comments.by_date_desc
        else
          comments.by_date_asc
        end
      end
    end
    
    module ClassMethods
      
      @@comments_order = :desc
      
      def comments_order
        @@comments_order
      end
      
      def comments_order=(order)
        @@comments_order = order
      end
      
      def acts_as_commentable(options = {})
        raise "acts_as_commentable requires a comment_class parameter." if options[:comment_class].blank?
        comment_class = options[:comment_class]
        @@comments_order = options[:order] || :desc

        has_many comment_class.to_s.pluralize.downcase.to_sym, as: :commentable
        index [[comment_class.to_s.pluralize.downcase, Mongo::ASCENDING]]
      end

      def acts_as_commentable_author(options = {})
        raise "acts_as_commentable_author requires a comment_class parameter." if options[:comment_class].blank?
        comment_class = options[:comment_class]
        field (options[:name_field] || :name).to_sym, as: :name
        field (options[:avatar_field] || :avatar).to_sym, as: :avatar
        has_many comment_class.to_s.pluralize.downcase.to_sym, as: :author
        index [[comment_class.to_s.pluralize.downcase, Mongo::ASCENDING]]
      end
      
      def acts_as_commentable_comment(options = {})
        include Mongoid::Tree
        field (options[:text_field] || :text).to_sym, as: :text
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
end
