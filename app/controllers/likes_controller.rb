class LikesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    current_user.add_like(post)
    redirect_to posts_path, notice: "いいねしました"
  end

  def destroy
    post = Post.find(params[:post_id])
    current_user.remove_like(post)

    redirect_to posts_path, notice: "いいねを解除しました", status: :see_other
  end
end
