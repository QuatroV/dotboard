class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    @posts = Post.order(created_at: :desc).page(params[:page])
  end

  # GET /posts/1 or /posts/1.json
  def show
    @comments = Comment.where(post_id: @post.id).to_a
    @new_comment = Comment.new
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params.merge(author_id: current_user.id))
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
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
    Comment.where(post_id: @post.id).destroy_all
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post and its comments was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def my_posts
    @posts = Post.where(author_id: current_user.id).page(params[:page])
    render "my_posts"
  end

  def discussed_posts
    date = Date.today
    @posts = Post.where(:created_at => (date.beginning_of_day..date.end_of_day)).order(comments_count: :desc).limit(5)
    render "discussed_posts"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, :author_id, :image)
    end
end
