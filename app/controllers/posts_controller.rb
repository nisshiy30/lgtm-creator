class PostsController < ApplicationController
  include ImageProcessing

  def index
    @q= current_user.posts.ransack(params[:q])
    @posts = @q.result.page(params[:page]).per(12).order(id: :desc)
  end

  def create
    processed_image = build(permit_params[:image].path)
    File.open(processed_image.path) do |file|
      @image_binary = file.read
    end
    @post = current_user.posts.new(
      name: permit_params[:name],
      image: @image_binary,
      filetype: permit_params[:image].content_type,
    )
    @post.save!
    redirect_to posts_path
  end

  def image
    @post = Post.find(params[:id])
    send_data @post.image, type: @post.filetype
  end

  def download
    @post = Post.find(params[:id])
    send_data @post.image, type: @post.filetype, disposition: 'attachment'
  end

  def destroy
    Post.find(params[:id]).destroy
    flash[:success] = "image deleted"
    redirect_to posts_path
  end

  private

  def permit_params
    params.require(:post).permit(:name, :image)
  end
end
