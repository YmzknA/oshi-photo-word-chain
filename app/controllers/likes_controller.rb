class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    if current_user.liked?(@post)
      redirect_to posts_path, alert: 'すみません！そんなに何度も、いいねボタンを押さないで！'
    else
      current_user.add_like(@post)
      @like = current_user.likes.find_by(post_id: @post.id)

      @like.broadcast_replace_to(
        'posts_likes_channel',
        partial: 'posts/likes_count',
        locals: {
          post: @post
        },
        target: "likes-count-#{@post.id}"
      )
    end
  end

  def destroy
    @like = current_user.likes.find_by(post_id: params[:id])
    if @like.present?

      @post = @like.post
      current_user.remove_like(@post)

      @like.broadcast_replace_to(
        'posts_likes_channel',
        partial: 'posts/likes_count',
        locals: {
          post: @post
        },
        target: "likes-count-#{@post.id}"
      )
    else
      redirect_to posts_path, alert: 'すみません！そんなに何度も、いいねボタンを押さないで！'
    end
  end
end
