module Suj
  module Commentable
    class CommentsController < ApplicationController
      
      def index
        @parent = params[:commentable_model].constantize.find(params["#{params[:commentable_model].downcase}_id"])
        @comments = @parent.ordered_comments.roots.page(params[:page])
        respond_to do |format|
          format.html {
            redirect_to @parent
          }
          format.js {
            render :partial => 'suj/commentable/index', :formats => [:js], :locals => { :comments => @comments, :commentable => @parent }
          }
        end
      end
      
      def create
        @parent = params[:commentable_model].constantize.find(params["#{params[:commentable_model].downcase}_id"])
        @comment = @parent.comments.new(params[:comment].merge(:author => commentable_user))

        respond_to do |format|
          format.html {
            logger.warn("Failed to save new comment") if ! @comment.save
            redirect_to :back 
          }
          format.js {
            if @comment.save
              render :partial => 'suj/commentable/item', :locals => { :comment => @comment, :commentable => @parent }
            else
              logger.warn("Failed to save new comment")
              render :nothing => true
            end
          }
        end
      end

      def like
        @comment = Suj::Commentable::Comment.find(params[:id])
        @weight = commentable_user.rate_weight || 1
        @comment.rate_and_save @weight, commentable_user
        respond_to do |format|
          format.html {
            redirect_to :back 
          }
          format.js {
            render :partial => 'suj/commentable/rate', :locals => { :comment => @comment }
          }
        end
      end

      def unlike
        @comment = Comment.find(params[:id])
        @weight = (commentable_user.rate_weight || 1) * -1
        @comment.rate_and_save @weight, commentable_user
        respond_to do |format|
          format.html {
            redirect_to :back 
          }
          format.js {
            render :partial => 'suj/commentable/rate', :locals => { :comment => @comment }
          }
        end
      end
    end
  end
end
