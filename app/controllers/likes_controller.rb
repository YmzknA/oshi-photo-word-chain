class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    current_user.add_like(@post)
    @like = current_user.likes.find_by(post_id: @post.id)

    @like.broadcast_replace_to(
      "posts_likes_channel",
      partial: "posts/likes_count",
      locals: { 
        post: @post
      },
      target: "likes-count-#{ @post.id }"
    )
  end

  def destroy
    @like = current_user.likes.find_by(post_id: params[:id])
    @post = @like.post
    current_user.remove_like(@post)

    @like.broadcast_replace_to(
      "posts_likes_channel",
      partial: "posts/likes_count",
      locals: { 
        post: @post
      },
      target: "likes-count-#{ @post.id }"
    )
  end
end
