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

      def hide
        destroy
      end

      def unhide

        @comment = Suj::Commentable::Comment.find(params[:id])

        if ! commentable_user
          render :text => "Need to login to unhid or delete comments", :status => :unauthorized
          return
        end

        if @comment.enabled? and ! commentable_user.can_hid_comment?(@comment)
          render :text => "You are not authorized to unhid this comment.", :status => :unauthorized
          return
        end

        @comment.enable!
        respond_to do |format|
          format.html { redirect_to :back }
          format.js { render :partial => 'suj/commentable/destroy', :locals => { :comment => @comment } }
        end
      end

      def destroy
        @comment = Suj::Commentable::Comment.find(params[:id])

        if ! commentable_user
          render :text => "Need to login to hid or delete comments", :status => :unauthorized
          return
        end

        if @comment.enabled? and ! commentable_user.can_hid_comment?(@comment)
          render :text => "You are not authorized to hid this comment.", :status => :unauthorized
          return
        end

        if !@comment.enabled? and ! commentable_user.can_delete_comment?(@comment)
          render :text => "You are not authorized to delete this comment.", :status => :unauthorized
          return
        end

        @comment.destroy
        respond_to do |format|
          format.html {
            redirect_to :back
          }
          format.js {
            render :partial => 'suj/commentable/destroy', :locals => { :comment => @comment }
          }
        end
      end

      def open
        @comment = Suj::Commentable::Comment.find(params[:id])
        @comment.open
        respond_to do |format|
          format.html { redirect_to :back }
          format.js { render :partial => 'suj/commentable/open', :locals => { :comment => @comment } }
        end
      end

      def close
        @comment = Suj::Commentable::Comment.find(params[:id])
        @comment.close
        respond_to do |format|
          format.html { redirect_to :back }
          format.js { render :partial => 'suj/commentable/open', :locals => { :comment => @comment } }
        end
      end

      def like
        @comment = Suj::Commentable::Comment.find(params[:id])
        if commentable_user
          @weight = commentable_user.rate_weight || 1
          @comment.rate_and_save @weight, commentable_user
        end
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
        if(commentable_user)
          @weight = (commentable_user.rate_weight || 1) * -1
          @comment.rate_and_save @weight, commentable_user
        end
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
