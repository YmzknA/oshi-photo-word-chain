class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    current_user.add_like(@post)
    @like = current_user.likes.find_by(post_id: @post.id)

    respond_to do |format|
      @like.broadcast_append_to("like_channel")
      format.turbo_stream
    end
  end

  def destroy
    @post = current_user.likes.find_by(post_id: params[:id]).post
    current_user.remove_like(@post)
  end
end
