class Book
  include Mongoid::Document
  include Suj::Commentable
  acts_as_commentable :order => :desc, :max_depth => 3
  
  def before_destroy_comment(comment)
    raise "DELETING COMMENT #{comment.text}"
  end
  
  def after_create_comment(comment)
    logger.info("CREATED COMMENTO #{comment.text}")
  end
  
  def after_like_comment(comment, user)
    logger.warn("############ User #{user.name} liked comment #{comment.text}")
  end

  def after_unlike_comment(comment, user)
    logger.warn("############ User #{user.name} did not like comment #{comment.text}")
  end
end
