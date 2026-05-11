class CommentsController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    @comment = Current.user.comments.new(comment_params)
    @comment.post_id = @post.id

    if @comment.save
      redirect_to post_path(@post), notice: "コメントを投稿しました"
    else
      redirect_to post_path(@post), alart: "コメントの投稿に失敗しました"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    if @comment.user == Current.user
      @comment.destroy
      redirect_to post_path(params[:post_id]), notice: "コメントを削除しました"
    else
      redirect_to post_path(params[:post_id]), alert: "権限がありません"
  end

end

private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
