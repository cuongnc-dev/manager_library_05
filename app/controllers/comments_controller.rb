class CommentsController < ApplicationController
  before_action :load_comment, only: [:destroy, :update]

  def create
    @comment = Comment.new comment_params
    respond_to do |format|
      if @comment.save
        @status = true
        format.js
        users_follow = User.list_users_follow_book(@comment.book_id,
          current_user.email)
        @comment.notification_new_comment(current_user, users_follow, @comment)
      else
        @status = false
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update_attributes comment_params
        format.json {render json: {update_status: :true}}
      else
        format.json {render json: {update_status: :false}}
      end
    end
  end

  def destroy
    if @comment.destroy
      @status = true
    else
      @status = false
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit :content, :book_id, :user_id
  end

  def load_comment
    @comment = Comment.find_by id: params[:id]
    return if @comment
    flash[:waring] = t "comments.comment_not_found"
  end
end
