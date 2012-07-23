class CommentsController < Suj::Commentable::CommentsController
 
  def create
    super
  end 
  
  def destroy
    super
  end

  def like
    super
  end

  def unlike
    super
  end
  # Override this method to return the user model used to create comments and rate
  # comments.
  def commentable_user
    Author.first
  end

end
