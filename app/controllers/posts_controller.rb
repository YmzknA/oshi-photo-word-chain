class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ create destroy ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all.order(created_at: :desc)
    @post = Post.new
  end

  # GET /posts/1 or /posts/1.json
  def show
    @posts = Post.all.order(created_at: :desc)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    if current_user?(@post.user)
      render "edit"
    else
      redirect_to post_path(@post), notice: "You can't edit this post"
    end
  end

  def liked
    @liked_posts = current_user.liked_posts
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @posts = Post.all.order(created_at: :desc)
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        @post.broadcast_prepend_to(
          "posts_likes_channel",
          partial: "posts/broadcast_first_post_content",
          locals: {
            post: @post
          }
        )

        format.html { redirect_to posts_path, notice: "Post was successfully created." }
        format.turbo_stream { flash.now[:notice] = "Post was successfully created." }
      else
        format.html { render action: :index , status: :unprocessable_entity }
      end

      notice = "Post was successfully created."
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    @post.broadcast_remove_to("posts_channel")
    redirect_to posts_path, notice: 'Post was successfully destroyed.'

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:name, :body, :image, :url)
    end

    def current_user?(user)
      user == current_user
    end
end
