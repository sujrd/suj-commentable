class CommentsController < ApplicationController
  def create
    @parent = params[:commentable_model].constantize.find(params["#{params[:commentable_model].downcase}_id"])
    @comment = @parent.comments.new(params[params[:comment_model].downcase])

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
  
  def rate
    @comment = Comment.find(params[:id])
    @author = params[:author_model].constantize.find(params["#{params[:author_model].downcase}_id"])
    @comment.rate_and_save (params[:rate].to_i || 1), @author
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
