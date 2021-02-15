class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  belongs_to :parent, optional: true, class_name: "Comment"

  def comments
    Comment.where(commentable: commentable, parent_id: id)
  end

  def destroy
    if self.parent_id.nil? && self.comments.empty?
      super
    else
      update(deleted: true)
    end
  end
end
