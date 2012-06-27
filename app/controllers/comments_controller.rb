class CommentsController < ApplicationController
  def create
    @parent = params[:commentable_model].constantize.find(params["#{params[:commentable_model].downcase}_id"])
    @comment = @parent.comments.new(params[params[:comment_model].downcase])
    logger.warn("Failed to save new comment") if ! @comment.save

    respond_to do |format|
      format.html { redirect_to :back }
      format.js {
        render :partial => 'suj/commentable/item', :locals => { :comment => @comment, :commentable => @parent }
      }
    end
  end
end
